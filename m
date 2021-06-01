Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86656C4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 18:19:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D719613BD
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 18:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D719613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E6D524028E;
	Tue,  1 Jun 2021 18:19:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Akok5m9RlIB; Tue,  1 Jun 2021 18:19:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D3B984014D;
	Tue,  1 Jun 2021 18:19:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE574C000D;
	Tue,  1 Jun 2021 18:19:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B018C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FCE96060D
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rErJ-Z4aBqrA for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 17:42:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B6B4605DE
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:42:20 +0000 (UTC)
Received: by mail-qk1-x72d.google.com with SMTP id q10so15112464qkc.5
 for <iommu@lists.linux-foundation.org>; Tue, 01 Jun 2021 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9MohaJcbxFVYSnX31aM9HSDnOhmBxW3aa4nKD3vvtGk=;
 b=q4Mswj45AOw5p0wm2tN+SJ9lEDiwbrs4mSFbvbJMb8cIl5poSO0vjh0lS1HeOUaW7Z
 h8T0ssfEyAn+iJmHsfRlIvdYaHSJ4NCEqYurrSSqIqGqVnaSjmZS+WIk/zMSTOYexPjC
 Kkg5wbTVq1AkDI82LHGE72t+nQIi1roh+cGwkXiIx1LvzpdQlrnVzKCLvWvwQ3zV1TDH
 gc8Q2LeVKMkkfSStHjC4nbBtgyEXTF1cCPnWxHDLVlBp5kdkk6wSSlgYpSyT0ruPKEZa
 310R+LSTGt0i0P4wOgozsEGyLGYJaI0hl6aK3eRhaJBmwUJPtwhhvSIy9JAyv5MA+zif
 0C3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9MohaJcbxFVYSnX31aM9HSDnOhmBxW3aa4nKD3vvtGk=;
 b=FVJuLMwKJTJ1VWJvWNGJBkqBnSxDE6UYfmcE1nYAZXVY7OPpNF63f5bTtv1JEfZMhv
 vtS4T7BedZR2hafKbebgPkkATuCf8r4j102XktmTNKCPX12FMwtJeDEs6uLtS8ZCPHiJ
 k0aD0Ti+Ow5X5mVv34zj92lSD+oB3YLszcKCG6pUSDd6uXuYaD1CQTayZJpV+d5u4o5I
 rRyVbdWdU2WuJXKUuLoL7yM3YyKsQcbLk2Sy3rs6QzEtgj3sXiUbLFSRrp/MhTt07jlX
 FF2oeDdGt8Td8zeCCouMYXsfkcwqNtQDp9IVdztTghX4riT9wzkqoVmiugLPwqUXRsZ6
 Fo1A==
X-Gm-Message-State: AOAM532k42Ci873JGn0pubbGSMGbu1ZSEb7yNyNhxZOBZCHYy9vtNm6O
 L59o+0oJHUKhjg86h92xcghTGNQbC19tmAgLgw==
X-Google-Smtp-Source: ABdhPJxb9G4H7H2iZTBbmY6dvvnDCTaeConQExPqDshL4kHeRVQImQJr4o/p2VCeQCsEHu0g66HzA8KIEIqznYDHyW4=
X-Received: by 2002:a37:424c:: with SMTP id p73mr23344013qka.465.1622569338850; 
 Tue, 01 Jun 2021 10:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHn8xckNXci+X_Eb2WMv4uVYjO2331UWB2JLtXr_58z0Av8+8A@mail.gmail.com>
 <cc58c09e-bbb5-354a-2030-bf8ebb2adc86@iogearbox.net>
 <7f048c57-423b-68ba-eede-7e194c1fea4e@arm.com>
In-Reply-To: <7f048c57-423b-68ba-eede-7e194c1fea4e@arm.com>
From: Jussi Maki <joamaki@gmail.com>
Date: Tue, 1 Jun 2021 19:42:07 +0200
Message-ID: <CAHn8xckNt3smeQPi3dgq5i_3vP7KwU45pnP5OCF8nOV_QEdyMA@mail.gmail.com>
Subject: Re: Regression 5.12.0-rc4 net: ice: significant throughput drop
To: Robin Murphy <robin.murphy@arm.com>
X-Mailman-Approved-At: Tue, 01 Jun 2021 18:19:34 +0000
Cc: jroedel@suse.de, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, jesse.brandeburg@intel.com, hch@lst.de,
 iommu@lists.linux-foundation.org, intel-wired-lan@lists.osuosl.org,
 anthony.l.nguyen@intel.com, bpf <bpf@vger.kernel.org>, davem@davemloft.net
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

Hi Robin,

On Tue, Jun 1, 2021 at 2:39 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >> The regression shows as a significant drop in throughput as measured
> >> with "super_netperf" [0],
> >> with measured bandwidth of ~95Gbps before and ~35Gbps after:
>
> I guess that must be the difference between using the flush queue
> vs. strict invalidation. On closer inspection, it seems to me that
> there's a subtle pre-existing bug in the AMD IOMMU driver, in that
> amd_iommu_init_dma_ops() actually runs *after* amd_iommu_init_api()
> has called bus_set_iommu(). Does the patch below work?

Thanks for the quick response & patch. I tried it out and indeed it
does solve the issue:

# uname -a
Linux zh-lab-node-3 5.13.0-rc3-amd-iommu+ #31 SMP Tue Jun 1 17:12:57
UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
root@zh-lab-node-3:~# ./super_netperf 32 -H 172.18.0.2
95341.2

root@zh-lab-node-3:~# uname -a
Linux zh-lab-node-3 5.13.0-rc3-amd-iommu-unpatched #32 SMP Tue Jun 1
17:29:34 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
root@zh-lab-node-3:~# ./super_netperf 32 -H 172.18.0.2
33989.5
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
