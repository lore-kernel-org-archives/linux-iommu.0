From: Manfred Schwarb <manfred99-OI3hZJvNYWs@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Add quirk for broken Marvell 88SE91xx SATA
Date: Mon, 19 Aug 2013 11:50:53 +0200
Message-ID: <5211EA7D.1050400@gmx.ch>
References: <519A93F0.8070606@gmx.ch> <20130521203526.GE7424@8bytes.org>
	<51D3E691.8030307@gmx.ch> <20130730113659.GJ28811@8bytes.org>
	<51F92832.2070102@gmx.ch> <51FB7C08.40708@gmx.ch>
	<20130802094326.GM28811@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130802094326.GM28811-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Am 02.08.2013 11:43, schrieb Joerg Roedel:
> Hi Manfred,
>
> On Fri, Aug 02, 2013 at 11:29:44AM +0200, Manfred Schwarb wrote:
>> Sorry, I completely goofed my testing, my apology.
>> I thought both disks I looked at were hanging on the builtin Marvell 88SE9172,
>> but one disk is attached to a Marvell 88SE9123 PCIe card.
>>
>> So the picture is much clearer now:
>>
>> The disk hanging on the Marvell 88SE9123 PCIe card gives without the patch
>>    ata14.00 failed to IDENTIFY(I/O Error, err_mask=0x4)
>> With the patch, this controller works flawless.
>>
>> The disk hanging on the built-in Marvell 88SE9172 (soldered on the mainboard)
>> gives with and without the patch
>>    ata20.00 failed to IDENTIFY(INIT_DEV_PARAMS failed, err_mask=0x80)
>>
>> So the patch works for my PCIe card, but not for my mainboard controller.
>
> Thanks for testing the patch. Can you please find out the PCI vendor and
> device-ids for the on-board and the PCIe STATA controlers? A dmesg after
> the boot would also be helpful. In short I need the output of (as root):
>
> # dmesg
> # lscpi -vvv
> # lspci -nvvv
>
>

Have you any idea what is going wrong with my on-board controller? Is perhaps the
quirk applied too late, and some device identification is done even before the
quirk becomes active? If you need some specific debug output, just ask.

It seems the "requester" patches are somewhat stalled, so would it make sense
to apply the Intel/AMD patches nevertheless [even for 3.12?], they can do no harm,
I think, impact would be restricted to some few devices.


Cheers,
Manfred


> Thanks,
>
> 	Joerg
>
>
>
