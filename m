Return-Path: <SRS0=9mGv=N7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF271C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Sep 2021 03:34:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F9B61178
	for <iommu@archiver.kernel.org>; Thu,  9 Sep 2021 03:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69F9B61178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FA154036F;
	Thu,  9 Sep 2021 03:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JJ9cRd95s1d4; Thu,  9 Sep 2021 03:34:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B785340351;
	Thu,  9 Sep 2021 03:34:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99E8DC000F;
	Thu,  9 Sep 2021 03:34:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F0D3C000D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 03:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 395A54036F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 03:34:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ICge03gBEGk for <iommu@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 03:34:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A51440351
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 03:34:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F40031B;
 Wed,  8 Sep 2021 20:34:08 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 428463F73D;
 Wed,  8 Sep 2021 20:34:07 -0700 (PDT)
Subject: DPAA2 triggers, [PATCH] dma debug: report -EEXIST errors in
 add_dma_entry
To: Hamza Mahfooz <someguy@effective-light.com>, linux-kernel@vger.kernel.org
References: <20210518125443.34148-1-someguy@effective-light.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <fd67fbac-64bf-f0ea-01e1-5938ccfab9d0@arm.com>
Date: Wed, 8 Sep 2021 22:33:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518125443.34148-1-someguy@effective-light.com>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Dan Williams <dan.j.williams@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

+DPAA2, netdev maintainers
Hi,

On 5/18/21 7:54 AM, Hamza Mahfooz wrote:
> Since, overlapping mappings are not supported by the DMA API we should
> report an error if active_cacheline_insert returns -EEXIST.

It seems this patch found a victim. I was trying to run iperf3 on a 
honeycomb (5.14.0, fedora 35) and the console is blasting this error 
message at 100% cpu. So, I changed it to a WARN_ONCE() to get the call 
trace, which is attached below.


[  151.839693] cacheline tracking EEXIST, overlapping mappings aren't
supported
...
[  151.924397] Hardware name: SolidRun Ltd. SolidRun CEX7 Platform, BIOS
EDK II Aug  9 2021
[  151.932481] pstate: 40400005 (nZcv daif +PAN -UAO -TCO BTYPE=--)
[  151.938483] pc : add_dma_entry+0x218/0x240
[  151.942575] lr : add_dma_entry+0x218/0x240
[  151.946666] sp : ffff8000101e2f20
[  151.949975] x29: ffff8000101e2f20 x28: ffffaf317ac85000 x27:
ffff3d0366ecb3a0
[  151.957116] x26: 0000040000000000 x25: 0000000000000001 x24:
ffffaf317bbe8908
[  151.964257] x23: 0000000000000001 x22: ffffaf317bbe8810 x21:
0000000000000000
[  151.971397] x20: 0000000082e48000 x19: ffffaf317be6e000 x18:
ffffffffffffffff
[  151.978537] x17: 646574726f707075 x16: 732074276e657261 x15:
ffff8000901e2c2f
[  151.985676] x14: 0000000000000000 x13: 0000000000000000 x12:
0000000000000000
[  151.992816] x11: ffffaf317bb4c4c0 x10: 00000000ffffe000 x9 :
ffffaf3179708060
[  151.999956] x8 : 00000000ffffdfff x7 : ffffaf317bb4c4c0 x6 :
0000000000000001
[  152.007096] x5 : ffff3d0a9af66e30 x4 : 0000000000000000 x3 :
0000000000000027
[  152.014236] x2 : 0000000000000023 x1 : ffff3d0360aac000 x0 :
0000000000000040
[  152.021376] Call trace:
[  152.023816]  add_dma_entry+0x218/0x240
[  152.027561]  debug_dma_map_sg+0x118/0x17c
[  152.031566]  dma_map_sg_attrs+0x70/0xb0
[  152.035397]  dpaa2_eth_build_sg_fd+0xac/0x2f0 [fsl_dpaa2_eth]
[  152.041150]  __dpaa2_eth_tx+0x3ec/0x570 [fsl_dpaa2_eth]
[  152.046377]  dpaa2_eth_tx+0x74/0x110 [fsl_dpaa2_eth]
[  152.051342]  dev_hard_start_xmit+0xe8/0x1a4
[  152.055523]  sch_direct_xmit+0x8c/0x1e0
[  152.059355]  __dev_xmit_skb+0x484/0x6a0
[  152.063186]  __dev_queue_xmit+0x380/0x744
[  152.067190]  dev_queue_xmit+0x20/0x2c
[  152.070848]  neigh_hh_output+0xb4/0x130
[  152.074679]  ip_finish_output2+0x494/0x8f0
[  152.078770]  __ip_finish_output+0x12c/0x230
[  152.082948]  ip_finish_output+0x40/0xe0
[  152.086778]  ip_output+0xe4/0x2d4
[  152.090088]  __ip_queue_xmit+0x1b4/0x5c0
[  152.094006]  ip_queue_xmit+0x20/0x30
[  152.097576]  __tcp_transmit_skb+0x3b8/0x7b4
[  152.101755]  tcp_write_xmit+0x350/0x8e0
[  152.105586]  __tcp_push_pending_frames+0x48/0x110
[  152.110286]  tcp_rcv_established+0x338/0x690
[  152.114550]  tcp_v4_do_rcv+0x1c0/0x29c
[  152.118294]  tcp_v4_rcv+0xd14/0xe3c
[  152.121777]  ip_protocol_deliver_rcu+0x88/0x340
[  152.126302]  ip_local_deliver_finish+0xc0/0x184
[  152.130827]  ip_local_deliver+0x7c/0x23c
[  152.134744]  ip_rcv_finish+0xb4/0x100
[  152.138400]  ip_rcv+0x54/0x210
[  152.141449]  deliver_skb+0x74/0xdc
[  152.144846]  __netif_receive_skb_core.constprop.0+0x250/0x81c
[  152.150588]  __netif_receive_skb_list_core+0x94/0x264
[  152.155635]  netif_receive_skb_list_internal+0x1d0/0x3bc
[  152.160942]  netif_receive_skb_list+0x38/0x70
[  152.165295]  dpaa2_eth_poll+0x168/0x350 [fsl_dpaa2_eth]
[  152.170521]  __napi_poll.constprop.0+0x40/0x19c
[  152.175047]  net_rx_action+0x2c4/0x360
[  152.178792]  __do_softirq+0x1b0/0x394
[  152.182450]  run_ksoftirqd+0x68/0xa0
[  152.186023]  smpboot_thread_fn+0x13c/0x270
[  152.190115]  kthread+0x138/0x140

PS, it might not hurt to rate limit/_once this somehow to avoid a 
runtime problem if it starts to trigger.

Thanks,


> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
>   kernel/dma/debug.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 14de1271463f..dadae6255d05 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -566,11 +566,9 @@ static void add_dma_entry(struct dma_debug_entry *entry)
>   	if (rc == -ENOMEM) {
>   		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
>   		global_disable = true;
> +	} else if (rc == -EEXIST) {
> +		pr_err("cacheline tracking EEXIST, overlapping mappings aren't supported\n");
>   	}
> -
> -	/* TODO: report -EEXIST errors here as overlapping mappings are
> -	 * not supported by the DMA API
> -	 */
>   }
>   
>   static int dma_debug_create_entries(gfp_t gfp)
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
