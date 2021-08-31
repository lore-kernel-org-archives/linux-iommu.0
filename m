Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8AFC4320A
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 15:20:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184CF6103D
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 15:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 184CF6103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D07C6400C9;
	Tue, 31 Aug 2021 15:20:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JGp4lCTY4sQr; Tue, 31 Aug 2021 15:20:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 64A98404AA;
	Tue, 31 Aug 2021 15:20:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B6F6C0010;
	Tue, 31 Aug 2021 15:20:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED0DAC000E
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 15:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCBE1404AD
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 15:20:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SGeuJ_a0m2Hk for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 15:20:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF30B400C9
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 15:20:21 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id 17so17071842pgp.4
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bHjdW+TFSdvqPfi7vbsYmlySYD0qeWma8ZlepyZ1pyA=;
 b=vKMmKg2JfTEH2r2TLKjdeGLs50EV+1jZUgn5bOxg36v536g3yxVJyUm07AJrRe5zpl
 tBmmevtBUhZm2otLHjO+t6XZXSqKFmlgJCMuDJmWa/GXj0SoH6IO4AASbNQrCa0nh7qM
 B7KI7XsRMY0RH1QUZ2VUGE8whdNH2gKq9Z8kV8Ym5rAqaokVsDSlFZJi22dmYwhDgQhT
 USid/NU4WRGPSTarkDcXxdUTAx9LYuGrR6Nv4PIqqo7PphtFsJN7VG6hLWhI5/qBs3Di
 +x+drrXZWdPlOXc87KdUarIUyVQNpVlgBbEDUDQ2DCD3gwGIwD/mm2RVJSZt7qbmg0qd
 mMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bHjdW+TFSdvqPfi7vbsYmlySYD0qeWma8ZlepyZ1pyA=;
 b=GBW7ZYw9d8Rt2FVKas3vyYYtn5N7zNfVee4dPWCnc0xQh/KqzeszudS+vZfVItJ5FQ
 NoF4ZhWCw4hB5S/mT539QcEoPGFbHFtg7nqhI2Nmnz7x5nsDHQl7GbywTwawcqj22QyW
 DgJkQ3NjHltlg5OcABCSF1kXhMUAZGm2CInotey3MWogkQOhT6WC4voHfa53FpTKw/tu
 UC2/rzxszzyNIJZof4WE6xe+nKp30Uwvt5LQsi3IeAXXlp49CAaNSB9yZv3XmsTay/XA
 rWWRvHjfTheHxDxv45vh8L1wHgaXTRdvscprYjuvT8QMv1sdbfnRrBYtvRWmHsqA/ukx
 8Gig==
X-Gm-Message-State: AOAM5332HV10iR2PpUhqvIpNqr9JVa4Iu2fTxPiXrVdJP9G0fvhdFAwc
 LyOUht+DbeJX1SsxVz/p0Po=
X-Google-Smtp-Source: ABdhPJzSdF8ZTtYVUbdAWtHig1Ob457a20faxiqqeItSlT8AzOFj7ZlOHpfBE0oc7/WJzromHshTYw==
X-Received: by 2002:a62:8144:0:b0:3af:7e99:f48f with SMTP id
 t65-20020a628144000000b003af7e99f48fmr28970407pfd.2.1630423221259; 
 Tue, 31 Aug 2021 08:20:21 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 x8sm7986672pfj.128.2021.08.31.08.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Aug 2021 08:20:20 -0700 (PDT)
Subject: Re: [PATCH V4 00/13] x86/Hyper-V: Add Hyper-V Isolation VM support
To: Christoph Hellwig <hch@lst.de>
References: <20210827172114.414281-1-ltykernel@gmail.com>
 <20210830120036.GA22005@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <91b5e997-8d44-77f0-6519-f574b541ba9f@gmail.com>
Date: Tue, 31 Aug 2021 23:20:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210830120036.GA22005@lst.de>
Content-Language: en-US
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 dave.hansen@intel.com, netdev@vger.kernel.org, hpa@zytor.com,
 kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, sstabellini@kernel.org,
 sthemmin@microsoft.com, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 decui@microsoft.com, ardb@kernel.org, michael.h.kelley@microsoft.com,
 mingo@redhat.com, pgonda@google.com, rientjes@google.com, kuba@kernel.org,
 jejb@linux.ibm.com, martin.b.radev@gmail.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 linux-arm-kernel@lists.infradead.org, jgross@suse.com,
 martin.petersen@oracle.com, saravanand@fb.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 rppt@kernel.org, hannes@cmpxchg.org, akpm@linux-foundation.org,
 robin.murphy@arm.com, davem@davemloft.net, kirill.shutemov@linux.intel.com
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

Hi Christoph:

On 8/30/2021 8:00 PM, Christoph Hellwig wrote:
> Sorry for the delayed answer, but I look at the vmap_pfn usage in the
> previous version and tried to come up with a better version.  This
> mostly untested branch:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hyperv-vmap

No problem. Thank you very much for your suggestion patches and they are 
very helpful.


> 
> get us there for swiotlb and the channel infrastructure  I've started
> looking at the network driver and didn't get anywhere due to other work.
> 
> As far as I can tell the network driver does gigantic multi-megabyte
> vmalloc allocation for the send and receive buffers, which are then
> passed to the hardware, but always copied to/from when interacting
> with the networking stack.  Did I see that right?  Are these big
> buffers actually required unlike the normal buffer management schemes
> in other Linux network drivers?


For send packet, netvsc tries batching packet in send buffer if 
possible. It passes the original skb pages directly to
hypervisor when send buffer is not enough or packet length is larger 
than section size. These packets are sent via 
vmbus_sendpacket_pagebuffer() finally. Please see netvsc_send() for 
detail. The following code is to check whether the packet could be 
copied into send buffer. If not, the packet will be sent with original 
skb pages.

1239        /* batch packets in send buffer if possible */
1240        msdp = &nvchan->msd;
1241        if (msdp->pkt)
1242                msd_len = msdp->pkt->total_data_buflen;
1243
1244        try_batch =  msd_len > 0 && msdp->count < net_device->max_pkt;
1245        if (try_batch && msd_len + pktlen + net_device->pkt_align <
1246            net_device->send_section_size) {
1247                section_index = msdp->pkt->send_buf_index;
1248
1249        } else if (try_batch && msd_len + packet->rmsg_size <
1250                   net_device->send_section_size) {
1251                section_index = msdp->pkt->send_buf_index;
1252                packet->cp_partial = true;
1253
1254        } else if (pktlen + net_device->pkt_align <
1255                   net_device->send_section_size) {
1256                section_index = 
netvsc_get_next_send_section(net_device);
1257                if (unlikely(section_index == NETVSC_INVALID_INDEX)) {
1258                        ++ndev_ctx->eth_stats.tx_send_full;
1259                } else {
1260                        move_pkt_msd(&msd_send, &msd_skb, msdp);
1261                        msd_len = 0;
1262                }
1263        }
1264



For receive packet, the data is always copied from recv buffer.

> 
> If so I suspect the best way to allocate them is by not using vmalloc
> but just discontiguous pages, and then use kmap_local_pfn where the
> PFN includes the share_gpa offset when actually copying from/to the
> skbs.
> 
When netvsc needs to copy packet data to send buffer, it needs to 
caculate position with section_index and send_section_size.
Please seee netvsc_copy_to_send_buf() detail. So the contiguous virtual 
address of send buffer is necessary to copy data and batch packets.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
