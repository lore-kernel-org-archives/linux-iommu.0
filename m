From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Summary of LPC guest MSI discussion in Santa Fe
Date: Wed, 23 Nov 2016 15:12:41 -0500
Message-ID: <5835F839.40905@redhat.com>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
	<20161103220205.37715b49@t450s.home> <20161108024559.GA20591@arm.com>
	<83d7bf8e-1aa9-b61b-4e83-ba9da1926d19@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <83d7bf8e-1aa9-b61b-4e83-ba9da1926d19-Zp4isUonpHBD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jon Masters <jcm-Zp4isUonpHBD60Wz+7aTrA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/21/2016 12:13 AM, Jon Masters wrote:
> On 11/07/2016 07:45 PM, Will Deacon wrote:
>
>> I figured this was a reasonable post to piggy-back on for the LPC minutes
>> relating to guest MSIs on arm64.
>
> Thanks for this Will. I'm still digging out post-LPC and SC16, but the
> summary was much appreciated, and I'm glad the conversation is helping.
>
>>    1. The physical memory map is not standardised (Jon pointed out that
>>       this is something that was realised late on)
>
> Just to note, we discussed this one about 3-4 years ago. I recall making
> a vigorous slideshow at a committee meeting in defense of having a
> single memory map for ARMv8 servers and requiring everyone to follow it.
> I was weak. I listened to the comments that this was "unreasonable".
> Instead, I consider it was unreasonable of me to not get with the other
> OS vendors and force things to be done one way. The lack of a "map at
> zero" RAM location on ARMv8 has been annoying enough for 32-bit DMA only
> devices on 64-bit (behind an SMMU but in passthrough mode it doesn't
> help) and other issues beyond fixing the MSI doorbell regions. If I ever
> have a time machine, I tried harder.
>
>> Jon pointed out that most people are pretty conservative about hardware
>> choices when migrating between them -- that is, they may only migrate
>> between different revisions of the same SoC, or they know ahead of time
>> all of the memory maps they want to support and this could be communicated
>> by way of configuration to libvirt.
>
> I think it's certainly reasonable to assume this in an initial
> implementation and fix it later. Currently, we're very conservative
> about host CPU passthrough anyway and can't migrate from one microarch
> to another revision of the same microarch even. And on x86, nobody
> really supports e.g. Intel to AMD and back again. I've always been of
Thats primarily due to diff virt implentations ... vme vs svm.
1) thats not the case here; can argue cross arch variations .. gicv2 vs gicv3 vs gicv4 ...
    but cross vendor should work if arch and common feature map (like x86 libvirt can resolve)
    is provided
2) second chance to do it better; look n learn!
    and common thread i am trying to drive home here ... learn from past mistakes *and* good choices.


> the mind that we should ensure the architecture can handle this, but
> then cautiously approach this with a default to not doing it.
>
>> Alex asked if there was a security
>> issue with DMA bypassing the SMMU, but there aren't currently any systems
>> where that is known to happen. Such a system would surely not be safe for
>> passthrough.
>
> There are other potential security issues that came up but don't need to
> be noted here (yet). I have wanted to clarify the SBSA for a long time
> when it comes to how IOMMUs should be implemented. It's past time that
> we went back and had a few conversations about that. I've poked.
>
>> Ben mused that a way to handle conflicts dynamically might be to hotplug
>> on the entire host bridge in the guest, passing firmware tables describing
>> the new reserved regions as a property of the host bridge. Whilst this
>> may well solve the issue, it was largely considered future work due to
>> its invasive nature and dependency on firmware tables (and guest support)
>> that do not currently exist.
>
> Indeed. It's an elegant solution (thanks Ben) that I gather POWER
> already does (good for them). We've obviously got a few things to clean
> up after we get the basics in place. Again, I think we can consider it
> reasonable that the MSI doorbell regions are predetermined on system A
> well ahead of any potential migration (that may or may not then work)
> for the moment. Vendors will want to loosen this later, and they can
> drive the work to do that, for example by hotplugging a host bridge.
>
> Jon.
>
