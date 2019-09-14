Return-Path: <SRS0=SXOE=XJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C482C4CEC7
	for <iommu@archiver.kernel.org>; Sat, 14 Sep 2019 14:01:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F229B20717
	for <iommu@archiver.kernel.org>; Sat, 14 Sep 2019 14:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F229B20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ACFD6B59;
	Sat, 14 Sep 2019 14:01:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 664BDB50
	for <iommu@lists.linux-foundation.org>;
	Sat, 14 Sep 2019 14:01:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 153462C6
	for <iommu@lists.linux-foundation.org>;
	Sat, 14 Sep 2019 14:01:30 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id 4so14536207pld.10
	for <iommu@lists.linux-foundation.org>;
	Sat, 14 Sep 2019 07:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=SXwC5T6wCRhaSBRQu04uBARGF1aDUDc2HyVfMMcCfp8=;
	b=rCfIKKXsVoiTAQBUiw+eq2rYIuGtf7hB0NaKbouJXbxs3erT1zG+MAgwsEiYilPbCt
	X6b+a0uAgwCv3P3UOaNHTmQqg5SLKlSkvyHKYULmFq9qsPKfKpccoj6B2cJEn/3dONcC
	S8atGaTzfXQk4F+vDGcrHuMRdMbITMSJvmx0FiDO+6jVlhinslLaSGooQoZ54HQYRsZm
	iSPmHtNAhF05ySWMZ9BUTMRROnOZwNGdbOUuNeSsZRYiA5Kspm1+Z4jnhvIfouOWF1Cc
	3X6l707ABsOSBjv5zEfGWiArW3Fv7ZvPclvIbwXVif6/mcmro3p2euVT31vfie6rI6Xk
	21JA==
X-Gm-Message-State: APjAAAVEnHYeIMVqhkxLhM5IWLuqbdWqFSXXnwoUvSRSYZ2phl6voPZ4
	ToI2Ycib4fIWB9Ul/jfT06MTHQ==
X-Google-Smtp-Source: APXvYqwLzMQI8pZxkVqd8/Fy8A16315KeB9n6NzIBBSxCASBhPGKSRyvm9h7GHG8COZItU0wdTcuOQ==
X-Received: by 2002:a17:902:d685:: with SMTP id
	v5mr16361073ply.15.1568469690307; 
	Sat, 14 Sep 2019 07:01:30 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
	by smtp.gmail.com with ESMTPSA id u17sm6671227pgf.8.2019.09.14.07.01.27
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 14 Sep 2019 07:01:29 -0700 (PDT)
Date: Sat, 14 Sep 2019 07:01:29 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2019 07:00:16 PDT (-0700)
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
	separate file
In-Reply-To: <20190912140256.fwbutgmadpjbjnab@willie-the-truck>
From: Palmer Dabbelt <palmer@sifive.com>
To: will@kernel.org
Message-ID: <mhng-166dcd4f-9483-4aab-a83a-914d70ddb5a4@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Cc: julien.thierry@arm.com, catalin.marinas@arm.com,
	Will Deacon <will.deacon@arm.com>, christoffer.dall@arm.com,
	Atish Patra <Atish.Patra@wdc.com>, julien.grall@arm.com,
	gary@garyguo.net, linux-riscv@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu, rppt@linux.ibm.com,
	aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
	suzuki.poulose@arm.com, marc.zyngier@arm.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-arm-kernel@lists.infradead.org,
	Anup Patel <Anup.Patel@wdc.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, james.morse@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, 12 Sep 2019 07:02:56 PDT (-0700), will@kernel.org wrote:
> On Sun, Sep 08, 2019 at 07:52:55AM +0800, Guo Ren wrote:
>> On Mon, Jun 24, 2019 at 6:40 PM Will Deacon <will@kernel.org> wrote:
>> > > I'll keep my system use the same ASID for SMP + IOMMU :P
>> >
>> > You will want a separate allocator for that:
>> >
>> > https://lkml.kernel.org/r/20190610184714.6786-2-jean-philippe.brucker@arm.com
>>
>> Yes, it is hard to maintain ASID between IOMMU and CPUMMU or different
>> system, because it's difficult to synchronize the IO_ASID when the CPU
>> ASID is rollover.
>> But we could still use hardware broadcast TLB invalidation instruction
>> to uniformly manage the ASID and IO_ASID, or OTHER_ASID in our IOMMU.
>
> That's probably a bad idea, because you'll likely stall execution on the
> CPU until the IOTLB has completed invalidation. In the case of ATS, I think
> an endpoint ATC is permitted to take over a minute to respond. In reality, I
> suspect the worst you'll ever see would be in the msec range, but that's
> still an unacceptable period of time to hold a CPU.
>
>> Welcome to join our disscusion:
>> "Introduce an implementation of IOMMU in linux-riscv"
>> 9 Sep 2019, 10:45 Jade-room-I&II (Corinthia Hotel Lisbon) RISC-V MC
>
> I attended this session, but it unfortunately raised many more questions
> than it answered.

Ya, we're a long way from figuring this out.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
