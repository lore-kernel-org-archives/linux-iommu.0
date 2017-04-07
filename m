From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 0/3] virtio-iommu: a paravirtualized IOMMU
Date: Sat, 8 Apr 2017 00:19:22 +0300
Message-ID: <20170407211922.GA23772@redhat.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtio-dev-return-2063-gcvd-virtio-dev=m.gmane.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Content-Disposition: inline
In-Reply-To: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, cdall@linaro.org, will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, joro@8bytes.org, jasowang@redhat.com, alex.williamson@redhat.com, marc.zyngier@arm.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 07, 2017 at 08:17:44PM +0100, Jean-Philippe Brucker wrote:
> There are a number of advantages in a paravirtualized IOMMU over a full
> emulation. It is portable and could be reused on different architectures.
> It is easier to implement than a full emulation, with less state tracking.
> It might be more efficient in some cases, with less context switches to
> the host and the possibility of in-kernel emulation.

Thanks, this is very interesting. I am read to read it all, but I really
would like you to expand some more on the motivation for this work.
Productising this would be quite a bit of work. Spending just 6 lines on
motivation seems somewhat disproportionate. In particular, do you have
any specific efficiency measurements or estimates that you can share?

-- 
MST
