Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50516C3F68F
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 20:14:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09387222C4
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 20:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAcQKuCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09387222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D92682271F;
	Fri, 14 Feb 2020 20:14:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UtJdTTZHvbly; Fri, 14 Feb 2020 20:14:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 190B122636;
	Fri, 14 Feb 2020 20:14:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A073C08A4;
	Fri, 14 Feb 2020 20:14:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07E4CC0177
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 20:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E9F4622708
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 20:14:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PW5Dd91tsvQp for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 20:14:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id F269022636
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 20:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581711243;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=5+J9mN7qIff4x/XgVnlnO84/6A7Dob8s+t3pt91uWhY=;
 b=QAcQKuCIX12BrGQWfNR9LQEzi8umQ4rH5bMIt9OLr8WssHqLTvNp5JwpIrOP7MtDSL8mHd
 H+V5qDr5e5Qq8dUFAfSXB2Kwi+B/Xiac4UFnyK8Ke8pBJmOcIobbNoiPUbflHL0T3MBEFJ
 G8rGUYogwy+3DB4uIW1sOXqtHopHUNw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-Tr11GbC3NielePDsGY0TYQ-1; Fri, 14 Feb 2020 15:13:56 -0500
Received: by mail-qk1-f198.google.com with SMTP id t186so6998834qkf.9
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 12:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :mime-version:content-disposition;
 bh=5+J9mN7qIff4x/XgVnlnO84/6A7Dob8s+t3pt91uWhY=;
 b=EhrNy0UPGQcAzH/8lBOYrqEQ6iMsnN2/PDkGkP2PHruKSdSHSkdU1rJiY6xg43oNqz
 fvOW7k7BvKujNszCF4thC6qETQm/5AVGMAqwSCQ6XY7dDwct3NRvClwr5INsZIKh5P3t
 w5Pe3mqJuA/JEqHt5h4xoVO4OJJZA+vdii/SVeCh2qvTpfFWQuocoRHzD3FQ0eMLJILY
 JZcroMKVhLzIYHWVtJYNTLpnry6g+lXRu7nZge6hMYCJZc5UjKB1RRl+mL5bkXLwL0ZG
 xgmxrBYFilH+AvxxJxQ5S8lAz+6HBkp+kWAu4F+NMlRdDWpvgtkhLXC9aWJ5NSytnFI0
 KSIQ==
X-Gm-Message-State: APjAAAWPd2XFWVYVlgMbMh6SMqbwVb83UBbjGrEDq0ozAJmnKheje2MS
 rq9+uv+xjlUQPzn/xsseTYmFY1w4O4NszdFV3v/3E0O2HFTVuQsEVyDpritirfGLhDR3P8mOZpo
 70yZHUNG+JKv+FL09R75tGZatrWO0AQ==
X-Received: by 2002:a0c:f703:: with SMTP id w3mr3739713qvn.6.1581711235731;
 Fri, 14 Feb 2020 12:13:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwIzs0M+c9GspGzsmEUcg+KGaKUB/wBb7Gl4xPQV790T2cEiD8ll7LL/JTgI4zhc9E6DnFXgw==
X-Received: by 2002:a0c:f703:: with SMTP id w3mr3739696qvn.6.1581711235509;
 Fri, 14 Feb 2020 12:13:55 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id r3sm4015317qtc.85.2020.02.14.12.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 12:13:54 -0800 (PST)
Date: Fri, 14 Feb 2020 13:13:53 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
Subject: arm-smmu.1.auto: Unhandled context fault starting with 5.4-rc1
Message-ID: <20200214201353.qlbqcvpztcx55qud@cantor>
MIME-Version: 1.0
X-MC-Unique: Tr11GbC3NielePDsGY0TYQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Will,

On a gigabyte system with Cavium CN8xx, when doing a fio test against
an nvme drive we are seeing the following:

[  637.161194] arm-smmu arm-smmu.1.auto: Unhandled context fault: fsr=0x80000402, iova=0x8010003f6000, fsynr=0x70091, cbfrsynra=0x9000, cb=7
[  637.174329] arm-smmu arm-smmu.1.auto: Unhandled context fault: fsr=0x80000402, iova=0x801000036000, fsynr=0x70091, cbfrsynra=0x9000, cb=7
[  637.186887] arm-smmu arm-smmu.1.auto: Unhandled context fault: fsr=0x80000402, iova=0x8010002ee000, fsynr=0x70091, cbfrsynra=0x9000, cb=7
[  637.199275] arm-smmu arm-smmu.1.auto: Unhandled context fault: fsr=0x80000402, iova=0x8010003c7000, fsynr=0x70091, cbfrsynra=0x9000, cb=7
[  637.211885] arm-smmu arm-smmu.1.auto: Unhandled context fault: fsr=0x80000402, iova=0x801000392000, fsynr=0x70091, cbfrsynra=0x9000, cb=7
[  637.224580] arm-smmu arm-smmu.1.auto: Unhandled context fault: fsr=0x80000402, iova=0x801000018000, fsynr=0x70091, cbfrsynra=0x9000, cb=7
[  637.237241] arm-smmu arm-smmu.1.auto: Unhandled context fault: fsr=0x80000402, iova=0x801000360000, fsynr=0x70091, cbfrsynra=0x9000, cb=7
[  637.249657] arm-smmu arm-smmu.1.auto: Unhandled context fault: fsr=0x80000402, iova=0x8010000ba000, fsynr=0x70091, cbfrsynra=0x9000, cb=7
[  637.262120] arm-smmu arm-smmu.1.auto: Unhandled context fault: fsr=0x80000402, iova=0x80100003e000, fsynr=0x70091, cbfrsynra=0x9000, cb=7
[  637.274468] arm-smmu arm-smmu.1.auto: Unhandled context fault: fsr=0x80000402, iova=0x801000304000, fsynr=0x70091, cbfrsynra=0x9000, cb=7

I also reproduced with 5.5-rc7, and will check 5.6-rc1 later today. I couldn't narrow it down further into 5.4-rc1.
I don't know smmu or the code well, any thoughts on where to start digging into this?

fio test that is being run is:

#fio -filename=/dev/nvme0n1 -iodepth=64 -thread -rw=randwrite -ioengine=libaio -bs=4k -runtime=43200 -size=-group_reporting -name=mytest -numjobs=32


Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
