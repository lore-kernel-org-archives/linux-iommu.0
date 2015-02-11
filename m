From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH/RFC 0/4] Probe deferral for IOMMU DT integration
Date: Wed, 11 Feb 2015 10:37:46 +0100
Message-ID: <54DB22EA.3050507@samsung.com>
References: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
	<2115835102.210232.1423348884955.JavaMail.open-xchange@oxbaltgw04.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <2115835102.210232.1423348884955.JavaMail.open-xchange-h4m1HHXQYNGZU4JK52HgGMgmgJlYmuWJ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2015-02-07 23:41, arnd-r2nGTMty4D4@public.gmane.org wrote:
> Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> hat am 6. Februar 2015 um 01:31
> geschrieben:
>> The requirement for this is based on a previous patch to add clock
>> support to the ARM SMMU driver[2]. Once we have clock support, it's
>> possible that the driver itself may need to be defered which breaks
>> a bunch of assumptions about how SMMU probing is supposed to work.
>   
> Hi Laura,
>   
> I was hoping that we would not need this, and instead treat the iommu in
> the same way as timers and SMP initialization, both
> of which need to be run early at boot time but may rely on clock controllers
> to be initialized first.
>   
> Is there a specific requirement that makes this impossible here, or is your
> intention to solve the problem more nicely by allowing deferred probing
> over forcing the input clocks of the iommu to be early?

I case of Exynos SoCs there is also a dependency on power domains (some 
might
be disabled by the bootloader). It is convenient to use the whole device
infrastructure for this although it still doesn't provide any methods of
modelling the real power management dependencies. Right now I simply ignored
this problem and left it for the future.

I will check if this patchset helps in our case.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
