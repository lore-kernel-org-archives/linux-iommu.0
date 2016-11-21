From: Jon Masters <jcm@jonmasters.org>
Subject: Re: Summary of LPC guest MSI discussion in Santa Fe
Date: Sun, 20 Nov 2016 22:13:30 -0700
Message-ID: <83d7bf8e-1aa9-b61b-4e83-ba9da1926d19@jonmasters.org>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
 <20161103220205.37715b49@t450s.home> <20161108024559.GA20591@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161108024559.GA20591@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: drjones@redhat.com, jason@lakedaemon.net, kvm@vger.kernel.org, marc.zyngier@arm.com, benh@kernel.crashing.org, joro@8bytes.org, punit.agrawal@arm.com, linux-kernel@vger.kernel.org, arnd@arndb.de, diana.craciun@nxp.com, Eric Auger <eric.auger@redhat.com>, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com, ddutile@redhat.com, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, tglx@linutronix.de, robin.murphy@arm.com, dwmw@amazon.co.uk, christoffer.dall@linaro.org, eric.auger.pro@gmail.com
List-Id: iommu@lists.linux-foundation.org

On 11/07/2016 07:45 PM, Will Deacon wrote:

> I figured this was a reasonable post to piggy-back on for the LPC minutes
> relating to guest MSIs on arm64.

Thanks for this Will. I'm still digging out post-LPC and SC16, but the
summary was much appreciated, and I'm glad the conversation is helping.

>   1. The physical memory map is not standardised (Jon pointed out that
>      this is something that was realised late on)

Just to note, we discussed this one about 3-4 years ago. I recall making
a vigorous slideshow at a committee meeting in defense of having a
single memory map for ARMv8 servers and requiring everyone to follow it.
I was weak. I listened to the comments that this was "unreasonable".
Instead, I consider it was unreasonable of me to not get with the other
OS vendors and force things to be done one way. The lack of a "map at
zero" RAM location on ARMv8 has been annoying enough for 32-bit DMA only
devices on 64-bit (behind an SMMU but in passthrough mode it doesn't
help) and other issues beyond fixing the MSI doorbell regions. If I ever
have a time machine, I tried harder.

> Jon pointed out that most people are pretty conservative about hardware
> choices when migrating between them -- that is, they may only migrate
> between different revisions of the same SoC, or they know ahead of time
> all of the memory maps they want to support and this could be communicated
> by way of configuration to libvirt.

I think it's certainly reasonable to assume this in an initial
implementation and fix it later. Currently, we're very conservative
about host CPU passthrough anyway and can't migrate from one microarch
to another revision of the same microarch even. And on x86, nobody
really supports e.g. Intel to AMD and back again. I've always been of
the mind that we should ensure the architecture can handle this, but
then cautiously approach this with a default to not doing it.

> Alex asked if there was a security
> issue with DMA bypassing the SMMU, but there aren't currently any systems
> where that is known to happen. Such a system would surely not be safe for
> passthrough.

There are other potential security issues that came up but don't need to
be noted here (yet). I have wanted to clarify the SBSA for a long time
when it comes to how IOMMUs should be implemented. It's past time that
we went back and had a few conversations about that. I've poked.

> Ben mused that a way to handle conflicts dynamically might be to hotplug
> on the entire host bridge in the guest, passing firmware tables describing
> the new reserved regions as a property of the host bridge. Whilst this
> may well solve the issue, it was largely considered future work due to
> its invasive nature and dependency on firmware tables (and guest support)
> that do not currently exist.

Indeed. It's an elegant solution (thanks Ben) that I gather POWER
already does (good for them). We've obviously got a few things to clean
up after we get the basics in place. Again, I think we can consider it
reasonable that the MSI doorbell regions are predetermined on system A
well ahead of any potential migration (that may or may not then work)
for the moment. Vendors will want to loosen this later, and they can
drive the work to do that, for example by hotplugging a host bridge.

Jon.
