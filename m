From: Gaudenz Steinlin <gaudenz-Pp/UeI/YXckUgOneFgkt3A@public.gmane.org>
Subject: Re: Marvell 88NV9143 in mini-PCIe not working with intel_iommu=on
Date: Thu, 07 Mar 2013 10:25:22 +0100
Message-ID: <87zjyfy325.fsf@meteor.durcheinandertal.bofh>
References: <874ngpj3d9.fsf@meteor.durcheinandertal.bofh>
	<CAJtEV7Zyq3+YPu9Vvcxcm8nw41-ENjLuRHUzyFFzXQn-wiSf1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAJtEV7Zyq3+YPu9Vvcxcm8nw41-ENjLuRHUzyFFzXQn-wiSf1w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, jyli-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shun Fu <fushun-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


Hi Andrew

Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> On Tue, Mar 5, 2013 at 11:03 PM, Gaudenz Steinlin <gaudenz-Pp/UeI/YXckUgOneFgkt3A@public.gmane.org> wrote:
>>
>> [ Sending this to the MVUMI driver authors and the IOMMU list as I can't
>> tell which part is at fault. ]
>>
>> [ ... ]
>> [    4.342079] dmar: DRHD: handling fault status reg 2
>> [    4.342132] dmar: DMAR:[DMA Read] Request device [02:00.0] fault addr fffff000
>> [    4.342132] DMAR:[fault reason 02] Present bit in context entry is clear
>> [ ... ]
>> [   34.344078] mvumi 0000:02:00.1: no handshake response at state 0x2.
>> [   34.344115] mvumi 0000:02:00.1: isr : global=0x0,status=0x0.
>> [   34.344146] mvumi 0000:02:00.1: handshake failed at state 0x2.
>> [   34.344266] mvumi: probe of 0000:02:00.1 failed with error -22
>>
>
> Looks like another Marvell DMA source tag issue.

You are probably right with this. See below.

>
>> And the full lspic output for this device:
>>
>> gaudenz@meteor:~$ sudo lspci -vv -nnq -s 02:
>> 02:00.0 Mass storage controller [01ff]: Marvell Technology Group Ltd. Device [1b4b:91f3]
>>         Subsystem: Marvell Technology Group Ltd. Device [1b4b:9143]
>> ...
>>         Capabilities: [140 v1] Virtual Channel
>>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>>                 Arb:    Fixed- WRR32- WRR64- WRR128-
>>                 Ctrl:   ArbSelect=Fixed
>>                 Status: InProgress-
>>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>>                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
>>                         Status: NegoPending- InProgress-
>>
>> 02:00.1 Mass storage controller [0180]: Marvell Technology Group Ltd. Device [1b4b:9143] (rev 10)
>>         Subsystem: Marvell Technology Group Ltd. Device [1b4b:9143]
>> ...
>>         Kernel driver in use: mvumi
>>
>> 02:00.2 Non-Volatile memory controller [0108]: Marvell Technology Group Ltd. Device [1b4b:91e3] (prog-if 01)
>>         Subsystem: Marvell Technology Group Ltd. Device [1b4b:9143]
>>...
>
> In this case it seems like a multifunction device with 02:00.1 being
> the only function that the mvumi driver cares about.  So my guess is
> that 02:00.1 is issuing DMA with the incorrect tag of 02:00.0.
>
> Perhaps Alex Williamson can tell us about iommu device groups, whether
> it would be possible to group the functions together automatically and
> whether that would solve the problem. It should also be possible to
> adapt the quirk patch I posted recently to handle this, but I'm still
> waiting to hear if that patch has a future.

I adapted your quirk patch to my device and it works. As I'm very new to
this I don't know if my modifications are right or if there is a better
way to do this. Diff on top of the latest version of the quirk you
posted to the iommu list:

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 13323f2..0ba462a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1684,7 +1684,7 @@ static int map_ghost_dma_fn(struct dmar_domain *domain,
 
        fn_map = pci_get_dma_source_map(pdev);
 
-       for (fn = 1; fn < 8; fn++) {
+       for (fn = 0; fn < 8; fn++) {
                if (fn_map & (1 << fn)) {
                        err = domain_context_mapping_one(domain,
                                        pci_domain_nr(pdev->bus),
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d311100..21b664b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3314,6 +3314,7 @@ static const struct pci_dev_dma_multi_func_sources {
        { PCI_VENDOR_ID_MARVELL_2, 0x9128, (1<<0)|(1<<1)},
        { PCI_VENDOR_ID_MARVELL_2, 0x9130, (1<<0)|(1<<1)},
        { PCI_VENDOR_ID_MARVELL_2, 0x9172, (1<<0)|(1<<1)},
+       { PCI_VENDOR_ID_MARVELL_2, 0x9143, (1<<0)},
        { 0 }
 };

Gaudenz

-- 
Ever tried. Ever failed. No matter.
Try again. Fail again. Fail better.
~ Samuel Beckett ~
