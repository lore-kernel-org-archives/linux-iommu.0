Return-Path: <SRS0=/Eks=4X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FA4C3F2D1
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 01:14:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729062073D
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 01:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kscYDLu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729062073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6D58887601;
	Fri,  6 Mar 2020 01:14:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NolW4yWSDT3z; Fri,  6 Mar 2020 01:14:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C694587605;
	Fri,  6 Mar 2020 01:14:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 961AEC18DA;
	Fri,  6 Mar 2020 01:14:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8260EC013E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 01:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 70FF8221F0
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 01:14:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iq1UV8mxKLaA for <iommu@lists.linux-foundation.org>;
 Fri,  6 Mar 2020 01:14:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by silver.osuosl.org (Postfix) with ESMTPS id 2A44622177
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 01:14:28 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id z65so243456pfz.8
 for <iommu@lists.linux-foundation.org>; Thu, 05 Mar 2020 17:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=Ho+0RD0p4M7tpfqm+yllGyejJF11Nk19HY5HGVNRLT4=;
 b=kscYDLu8ng4LZZyzX8XW4wfmSOKUcnyvKv1uimDLeFs/xUIiEnbqMJnVmjxigvzsnu
 M9UcYycE1mrgcRNWfral1hHUWqKIGg5QHValx0+8qnULO6vDrHXjjFnKrIdQpsNgnBBi
 waRZzWzEuprY/E1RfMlOYxj+IbMMehNmAGrtDi5wIhc5bPoPlhIbyW8mocHiGrENAC0g
 bnbpX8NEMMfb5YpuTx0s0de+49Qp1mNSHVQfOg2sz107QqQStTL4qhcUcwriPg5yEfxn
 afT4ga3xB7MnJzFzkV6ZNB67NtiA2ZXzNHDPc7dcfwNpXy2KjvGl9v8BmiSjqkuzzxUt
 LKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=Ho+0RD0p4M7tpfqm+yllGyejJF11Nk19HY5HGVNRLT4=;
 b=nhkNwv0F2+JGQVAMe5hPbQoibykVaz4yQfUJBAyaZcYB9BH5gK/ch1Z2WGztbjgLoh
 s5Xb2ibQQ/1DTvapA9w9hG7YxpD+ODjc/wkdPJeJrYbytzTaRLcO5+pv5OtzPw7fWVKv
 k9GHRtlpccbCUaHcgg1unQgyw1zvnRpu2Bugp62JxDY4TcW7shagKSY5JMdxImNHLblU
 niKY+Jj62Hdk2b5ExHKXSO7uE6HvNBgG+JOjzXMv3sYwWBD5EHyKo3zbpKt5gjFRvFx+
 06antCXCyP78CXh7yPAqpJb2oQDNoDLX/9ktGHlTZ3s3VzvygdfzHUUFtB9OxTrb9a/f
 r3RQ==
X-Gm-Message-State: ANhLgQ2ygSZcVKWHQt2uVOjzgM+XDQRSkDru9BktiUmTTIwK7nMmLazu
 ku12DBwA33RX39s2+/jHUdg=
X-Google-Smtp-Source: ADFU+vtpFJLTWb+LOFK1Xu3CzXx+StCYZY1Eh+0qFG+EjzQmDnhqtk9hA4D/8gTdxON2wYNy4TU2hQ==
X-Received: by 2002:aa7:875a:: with SMTP id g26mr1156707pfo.193.1583457267331; 
 Thu, 05 Mar 2020 17:14:27 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id a22sm318870pfo.56.2020.03.05.17.14.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 05 Mar 2020 17:14:26 -0800 (PST)
Date: Thu, 5 Mar 2020 17:14:31 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: robin.murphy@arm.com, jroedel@suse.de
Subject: Possible bugs in iommu_map_sg()/iommu_map_dma_sg()
Message-ID: <20200306011430.GA17529@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi all,

I recently ran a 4GB+ allocation test case with my downstream
older-version kernel, and found two possible bugs. I then saw
the mainline code, yet don't find them getting fixed.

However, I am not 100% sure that they are real practical bugs
because I later figured out that my use case was not entirely
correct. So I'd like to get some advice first, before sending
any patch.


First problem is accumulating the pad_len in iommu_map_dma_sg.
My use case was to map a size of 4GB+ sg while the device did
not set its segmentation boundary -- leaving it to the default
32-bit mask.

00 of 14: s_length    90000, s->length    90000, iova_len 0
01 of 14: s_length   100000, s->length   100000, iova_len 90000
02 of 14: s_length   100000, s->length   100000, iova_len 190000
03 of 14: s_length   200000, s->length   200000, iova_len 290000
04 of 14: s_length   200000, s->length   200000, iova_len 490000
05 of 14: s_length 39c00000, s->length 39c00000, iova_len 690000
06 of 14: s_length   400000, s->length   400000, iova_len 3a290000
07 of 14: s_length   400000, s->length   400000, iova_len 3a690000
08 of 14: s_length   400000, s->length   400000, iova_len 3aa90000
09 of 14: s_length   400000, s->length   400000, iova_len 3ae90000
10 of 14: s_length   400000, s->length   400000, iova_len 3b290000
11 of 14: s_length   400000, s->length   400000, iova_len 3b690000
12 of 14: s_length fffff000, s->length fffff000, iova_len 3ba90000
12 of 14: prev->length 400000 + pad_len c4570000 = c4970000
13 of 14: s_length 1df41000, s->length 1df41000, iova_len 1fffff000
13 of 14: prev->length fffff000 + pad_len 1000 = 100000000

So, the problem here is adding the last pad_len 0x1000 to the
prev->length 0xfffff000, and writing the result back:
880                 if (pad_len && pad_len < s_length - 1) {
881                         prev->length += pad_len;

This 0x100000000 overflows that "unsigned int" prev->length.


Second problem is in the iommu_map_sg function. When it maps
iova to phys for each list, it uses previously padded length
instead of the actual s->dma_length, which means it possibly
maps some of the iova space to a physical address space that
is out of the allocated region. For a large value of pad_len
0xc4570000, it might end up map iova to somewhere invalid:
iova [0xc3b690000, 0xd00000000] ==>
  pa [0x0000000262800000, 0x0000000327170000]
  // size 0xc4970000, dma_size 0x400000

This 0x327170000 is out of actual physical address space for
my platform. And even for the small 0x1000 pad_len, it still
maps out of the allocated region.


For my use case, I made it work by setting the segmentation
boundary to a larger size, which shouldn't be wrong because
I need a contiguous iova space with no paddings in-between.

Yet, since the code is designed to take care of a "mask size
< IOVA size" case, I feel that we probably need to fix these
two issues.

For problem 1, should we change the type of length to size_t?

For problem 2, should we map each iova<=>pa using dma_length?

Thanks
Nicolin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
