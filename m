From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: Re: [RFC 0/3] virtio-iommu: a paravirtualized IOMMU
Date: Mon, 10 Apr 2017 19:39:24 +0100
Message-ID: <c6bb7071-f419-1346-7985-e9b4718894a8@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
 <20170407211922.GA23772@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <virtio-dev-return-2064-gcvd-virtio-dev=m.gmane.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20170407211922.GA23772@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, cdall@linaro.org, will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, joro@8bytes.org, jasowang@redhat.com, alex.williamson@redhat.com, marc.zyngier@arm.com
List-Id: iommu@lists.linux-foundation.org

On 07/04/17 22:19, Michael S. Tsirkin wrote:
> On Fri, Apr 07, 2017 at 08:17:44PM +0100, Jean-Philippe Brucker wrote:
>> There are a number of advantages in a paravirtualized IOMMU over a full
>> emulation. It is portable and could be reused on different architectures.
>> It is easier to implement than a full emulation, with less state tracking.
>> It might be more efficient in some cases, with less context switches to
>> the host and the possibility of in-kernel emulation.
> 
> Thanks, this is very interesting. I am read to read it all, but I really
> would like you to expand some more on the motivation for this work.
> Productising this would be quite a bit of work. Spending just 6 lines on
> motivation seems somewhat disproportionate. In particular, do you have
> any specific efficiency measurements or estimates that you can share?

The main motivation for this work is to bring IOMMU virtualization to the
ARM world. We don't have any at the moment, and a full ARM SMMU
virtualization solution would be counter-productive. We would have to do
it for SMMUv2, for the completely orthogonal SMMUv3, and for any future
version of the architecture. Doing so in userspace might be acceptable,
but then for performance reasons people will want in-kernel emulation of
every IOMMU variant out there, which is a maintenance and security
nightmare. A single generic vIOMMU is preferable because it reduces
maintenance cost and attack surface.

The transport code is the same as any virtio device, both for userspace
and in-kernel implementations. So instead of rewriting everything from
scratch (and the lot of bugs that go with it) for each IOMMU variation, we
reuse well-tested code for transport and write the emulation layer once
and for all.

Note that this work applies to any architecture with an IOMMU, not only
ARM and their partners'. Introducing an IOMMU specially designed for
virtualization allows us to get rid of complex state tracking inherent to
full IOMMU emulations. With a full emulation, all guest accesses to page
table and configuration structures have to be trapped and interpreted. A
Virtio interface provides well-defined semantics and doesn't need to guess
what the guest is trying to do. It transmits requests made from guest
device drivers to host IOMMU almost unaltered, removing the intermediate
layer of arch-specific configuration structures and page tables.

Using a portable standard like Virtio also allows for efficient IOMMU
virtualization when guest and host are built for different architectures
(for instance when using Qemu TCG.) In-kernel emulation would still work
with vhost-iommu, but a platform-specific vIOMMUs would have to stay in
userspace.

I don't have any measurements at the moment, it is a bit early for that.
The kvmtool example was developed on a software model and is mostly here
for illustrative purpose, a Qemu implementation would be more suitable for
performance analysis. I wouldn't be able to give meaning to these numbers
anyway, since on ARM we don't have any existing solution to compare it
against. One could compare the complexity of handling guest accesses and
parsing page tables in Qemu's VT-d emulation with reading a chain of
buffers in Virtio, for a very rough estimate.

Thanks,
Jean-Philippe
