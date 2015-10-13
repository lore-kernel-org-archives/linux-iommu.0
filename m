From: Jinpu Wang <jinpu.wang-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
Subject: Re: [RFI] WARNING: CPU: 0 PID: 14493 at
	drivers/iommu/intel-iommu.c:2048 __domain_mapping+0x37d/0x390()
Date: Tue, 13 Oct 2015 17:18:29 +0200
Message-ID: <CAMGffEkwcAzMQbvzNJw8_xFAr5YptEMLk4Vfu_QJiOjjTh9K_w@mail.gmail.com>
References: <CAMGffEmgpksfFhm5H9PB3n4ZWUEYbnC703xvSsQi0_hD1xtE5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMGffEmgpksfFhm5H9PB3n4ZWUEYbnC703xvSsQi0_hD1xtE5w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Christian Zander <christian-dt00mrq0sMmU+1/U8MakDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 12, 2015 at 3:29 PM, Jinpu Wang <jinpu.wang-EIkl63zCoXaH+58JC4qpiA@public.gmane.org> wrote:
> Hi experts,
>
> We hit warning below during test:
>
> [13560.541562] ERROR: DMA PTE for vPFN 0xc3a00 already set (to
> 42834a003 not 114600083)
> [13560.541696] ------------[ cut here ]------------
> [13560.541701] WARNING: CPU: 0 PID: 22427 at
> drivers/iommu/intel-iommu.c:2048 __domain_mapping+0x37d/0x390()
> [13560.541702] Modules linked in: dm_snapshot dm_bufio ibnbd_server(O)
> ibtrs_server(O) rdma_cm iw_cm ib_uverbs ipmi_dev
> intf ib_ipoib ib_cm ib_umad loop mlx4_ib ib_sa ib_mad ib_core ib_addr
> ipv6 hid_generic usbhid mlx4_core i2c_i801 ioatdm
> a ehci_pci sb_edac i2c_core ehci_hcd edac_core dca ipmi_si
> ipmi_msghandler button dm_mod sg e1000e
> [13560.541726] CPU: 0 PID: 22427 Comm: kworker/0:0 Tainted: G
>  O   3.18.21-1-storage #1
> [13560.541727] Hardware name: Supermicro X9SRL-F/X9SRL-F, BIOS 3.00 07/04/2013
> [13560.541730] Workqueue: ib_cm ib_destroy_cm_id [ib_cm]
> [13560.541731]  0000000000000009 ffff880109213968 ffffffff815bac45
> 0000000000000000
> [13560.541733]  0000000000000000 ffff8801092139a8 ffffffff81050d3c
> ffff8801092139c8
> [13560.541734]  0000000114600083 ffff88007992f0e8 0000000000000200
> 00000000000c3a00
> [13560.541736] Call Trace:
> [13560.541740]  [<ffffffff815bac45>] dump_stack+0x46/0x58
> [13560.541743]  [<ffffffff81050d3c>] warn_slowpath_common+0x8c/0xc0
> [13560.541744]  [<ffffffff81050d8a>] warn_slowpath_null+0x1a/0x20
> [13560.541746]  [<ffffffff814fc0ad>] __domain_mapping+0x37d/0x390
> [13560.541748]  [<ffffffff814fdced>] __intel_map_single+0x10d/0x1d0
> [13560.541749]  [<ffffffff814fdde9>] intel_map_page+0x39/0x40
>
> and during search I found a patch from Christian:
> http://permalink.gmane.org/gmane.linux.kernel.iommu/9993
>
> Seems we have similar error message at least, and we also map 4M
> memory each time, after several map, it triggered warning above, apply
> the patch seems fix the warning for us, but checking with lastest
> linus tree 4.3-rc4, it's not there yet, could you guys give some
> comment on the patch,  is it the right fix or we need to fix it
> another way, or it's simply imply driver bug?
>
> Please share your comments!
>
Ping,

Can you shed any light on this?


Regards,

Jack
