From: Thomas Kuther <tom-rbwR+HMEqnCsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Add quirk for broken Marvell 88SE91xx SATA
Date: Thu, 5 Dec 2013 20:42:14 +0000 (UTC)
Message-ID: <loom.20131205T212623-586@post.gmane.org>
References: <519A93F0.8070606@gmx.ch> <20130521203526.GE7424@8bytes.org>
	<51D3E691.8030307@gmx.ch> <20130730113659.GJ28811@8bytes.org>
	<51F92832.2070102@gmx.ch> <51FB7C08.40708@gmx.ch>
	<20130802094326.GM28811@8bytes.org> <5211EA7D.1050400@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Manfred Schwarb <manfred99@...> writes:

> 
> Have you any idea what is going wrong with my on-board controller? Is
> perhaps the quirk applied too late, and some device identification
> is done even before the quirk becomes active? If you need some specific
> debug output, just ask.
> 
> It seems the "requester" patches are somewhat stalled, so would it make 
> sense to apply the Intel/AMD patches nevertheless [even for 3.12?], they
> can do no harm, I think, impact would be restricted to some few devices.
> 
> Cheers,
> Manfred
> 

I have the same board (990FXA-UD5) and the same problem.

Applied the patch (against 3.12.2) and dmesg reads:
[    0.755642] AMD-Vi: Applying merge-fn quirk for device 0000:03:00.0
[    0.755648] AMD-Vi: Applying merge-fn quirk for device 0000:09:00.0

03:00 is the SATA controller, 09:00 the eSATA one.
ID's from `lscpi -nvvv` are identical to Manfred's.

Also, the device works OK when passed through to a Qemu VM using vfio-pci,
so basically it does work when IOMMU is enabled, just not on the host side.

A fix would be great, I'm willing to test, too.

Regards,
Thomas
