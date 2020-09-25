Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23001C4727F
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 06:35:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702ED2084C
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 06:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702ED2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E071186CF0;
	Fri, 25 Sep 2020 06:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VUKb-vIXkswy; Fri, 25 Sep 2020 06:35:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4ECB486CC8;
	Fri, 25 Sep 2020 06:35:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E304C0889;
	Fri, 25 Sep 2020 06:35:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EE62C0051
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 06:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1E39186CD4
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 06:35:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TRfTXosm3Dxt for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 06:35:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 13F1486CC8
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 06:35:38 +0000 (UTC)
Received: from mail-pg1-f199.google.com ([209.85.215.199])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1kLhKR-00012C-N5
 for iommu@lists.linux-foundation.org; Fri, 25 Sep 2020 06:35:36 +0000
Received: by mail-pg1-f199.google.com with SMTP id r4so1450170pgl.20
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 23:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Ln5tX4yeIXG1vWB0JQCDh49WVbM2bVqoaH/7mBdZWuQ=;
 b=CPoKQ0De8jhDeDrJgB/bo8tDdvBAqwGEcmMxD8NuEE7BoaOj4KQaADJJSPwnfSh8wu
 HpVKytQIcqO7LsaegGAAF1VJJbKZiw9iqmvA43dWqosneHA4/Js24Cc4CAH/v/jsEeth
 AqqjUvfMQ3U2CSCWYE9fIGsB8eJF55eCGVwJEb4i3H+05UTrUsUEaIykXwvxh7yWbtZm
 IVoREDQCr8/egWht8JR8BIbEAVr94na3KPQMjIiaqlaW1sfQoc7xU1prFK93vDsHtyeR
 RRymIjIDv+ftOHQWi0ujgzN1fR2Rhd7x2NUYYnggodebWnK1mXRGw791ZyiUC9c1xHDV
 LeNQ==
X-Gm-Message-State: AOAM530dgg0KXrzQAzttL5nGwwBLYdzKG3Efy/QfOJj/xWBDKLo/Ib5Z
 1n+5fdGy11isg6LUmjV5HRkhlWal+C7LZc9zFSFzabTpU83zoUnZI9XGEme4ucZ8KEs8uvqDCz9
 AFy9uIiNGyAooB2Yt0kygadvwQ/gsxoX4LEZp+d6gU3Hcll4=
X-Received: by 2002:a17:90a:ead5:: with SMTP id
 ev21mr1194855pjb.188.1601015734204; 
 Thu, 24 Sep 2020 23:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8MuHBZgL02bSNP/wDMTZTXNVYn/hmwUmkftK3PiogMdGhitdngDJ/ZY9ist3OCUOawC5KxQ==
X-Received: by 2002:a17:90a:ead5:: with SMTP id
 ev21mr1194830pjb.188.1601015733835; 
 Thu, 24 Sep 2020 23:35:33 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net.
 [220.133.187.190])
 by smtp.gmail.com with ESMTPSA id s13sm1196585pgo.56.2020.09.24.23.35.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Sep 2020 23:35:33 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config space
 not accessible after S3]
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200924194437.GA85997@otc-nc-03>
Date: Fri, 25 Sep 2020 14:35:29 +0800
Message-Id: <085B7CD2-95BA-4540-8858-AB090463536A@canonical.com>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
 <6CD003F6-DDF4-4C57-AD9E-79C8AB5C01BF@canonical.com>
 <20200924180905.GB85236@otc-nc-03> <20200924133938.6b93732f@x1.home>
 <20200924194437.GA85997@otc-nc-03>
To: "Raj, Ashok" <ashok.raj@intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Cc: Joerg Roedel <jroedel@suse.de>, "Jechlitschek,
 Christoph" <christoph.jechlitschek@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Rajat Jain <rajatja@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Raj,

> On Sep 25, 2020, at 03:44, Raj, Ashok <ashok.raj@intel.com> wrote:
> 
> Hi Alex
> 
>>> Apparently it also requires to disable RR, and I'm not able to confirm if
>>> CML requires that as well. 
>>> 
>>> pci_quirk_disable_intel_spt_pch_acs_redir() also seems to consult the same
>>> table, so i'm not sure why we need the other patch in bugzilla is required.
>> 
>> If we're talking about the Intel bug where PCH root ports implement
>> the ACS capability and control registers as dword rather than word
>> registers, then how is ACS getting enabled in order to generate an ACS
>> violation?  The standard ACS code would write to the control register
>> word at offset 6, which is still the read-only capability register on
>> those devices.  Thanks,
> 
> 
> Right... Maybe we need header log to figure out what exatly is happening. 
> 

Please let me know what logs you need.

As Bjorn mentioned earlier, there's currently no way to dump TLP header log?

Kai-Heng
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
