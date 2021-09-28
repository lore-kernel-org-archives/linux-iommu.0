Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C50C433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 06:25:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1A0611CB
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 06:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B1A0611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA01F402D3;
	Tue, 28 Sep 2021 06:25:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rs4TTF306iI8; Tue, 28 Sep 2021 06:25:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6871240229;
	Tue, 28 Sep 2021 06:25:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F6B6C0011;
	Tue, 28 Sep 2021 06:25:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6412C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 06:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9207D406DA
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 06:25:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rh9-VzMNxkvK for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 06:25:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B1BF5403C0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 06:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632810340;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wq1dVPtAXDMCZC9S+u92KoCxHpT0A4H8ulsqFHsRII=;
 b=iYzpm3mCwn7BhzwGwrV3Xa1Cl9lIvXZLjLoRo4i4C5Qq3d8EwsXeHSTv2zAdEuFAVHliFF
 /7xDikWMziL3YkE0lKdEuz/D9hVDcrxCqRHpLhQNvqI4NO9uihVnZzYYYzwLsknQzRmaWK
 ygWPqrbrQpP6UFhYe3p5SvHp0Jzr3oA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-lvsPr2DxPXOAQXFnclEmPA-1; Tue, 28 Sep 2021 02:25:37 -0400
X-MC-Unique: lvsPr2DxPXOAQXFnclEmPA-1
Received: by mail-wm1-f72.google.com with SMTP id
 m9-20020a05600c4f4900b003057c761567so686484wmq.1
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 23:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=9wq1dVPtAXDMCZC9S+u92KoCxHpT0A4H8ulsqFHsRII=;
 b=DG0nppl/rNRAFsRWdLMHH7IoVzv+XOTUhsGMmq1o17qv1VT0v0WxNfekWlzQSLwxA8
 Ag7LITyzRKtbX/86DYQF4TAIcivUCh+xgyEJJaHS6/6X/rPgYJHtoX7f6mzMivuS0OJd
 0L8bpzkdKo8RvIkXL33mlFDMdM1vpv4i9zQ2mCjqtCiWfMb9YioV1BVP49t9zo0ZQh0/
 qyZavCQelA5f14PCbXeaKanhDiHjb493Cs+LE1SSGTB8/plEIQ3R5ttXu2+NZe+qnVrv
 Ytd18l0+ML/C0+b0ghgsYgbnsjIA3x0BnK4jUU23u1HEmtlzPLyaV4W4kj3WYTktW6SV
 4zJA==
X-Gm-Message-State: AOAM533Mt4hfoDTR+r4lnxKNMGOq1Rpc1bdSXJBbEFB4Vx64JFTYg/S/
 PN4/nVp5RrPtIy3hMy1/0g5sCXxwZ3pAXkVK87rJnnBS47ZVUJfAGaA5P3sHWxgUMR3siTU5KU8
 CelI+9Ga8jN7hkeC/Q3cDtX19yreomA==
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr4278537wri.284.1632810336274; 
 Mon, 27 Sep 2021 23:25:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqSUu50iJ95OWE4UOFTINQsxuRK/ueiYpb9FlWfdG9FdcSiC/DUJ4GzrvCnuOU9QL4gLjBUA==
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr4278495wri.284.1632810336011; 
 Mon, 27 Sep 2021 23:25:36 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id l10sm1663709wmq.42.2021.09.27.23.25.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Sep 2021 23:25:35 -0700 (PDT)
Subject: Re: [PATCH v15 00/12] SMMUv3 Nested Stage Setup (IOMMU part)
To: Krishna Reddy <vdumpa@nvidia.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "will@kernel.org" <will@kernel.org>, "maz@kernel.org" <maz@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "tn@semihalf.com" <tn@semihalf.com>,
 "zhukeqian1@huawei.com" <zhukeqian1@huawei.com>
References: <20210411111228.14386-1-eric.auger@redhat.com>
 <BY5PR12MB37640C26FEBC8AC6E3EDF40BB3A79@BY5PR12MB3764.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <c3fcc2fb-3173-af83-2b30-423c2c1ab83d@redhat.com>
Date: Tue, 28 Sep 2021 08:25:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB37640C26FEBC8AC6E3EDF40BB3A79@BY5PR12MB3764.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "wangxingang5@huawei.com" <wangxingang5@huawei.com>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 Vikram Sethi <vsethi@nvidia.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Krishna,

On 9/27/21 11:17 PM, Krishna Reddy wrote:
> Hi Eric,
>> This is based on Jean-Philippe's
>> [PATCH v14 00/10] iommu: I/O page faults for SMMUv3
>> https://www.spinics.net/lists/arm-kernel/msg886518.html
>> (including the patches that were not pulled for 5.13)
>>
> Jean's patches have been merged to v5.14.
> Do you anticipate IOMMU/VFIO part patches getting into upstream kernel soon?

I am going to respin the smmu part rebased on v5.15. As for the VFIO
part, this needs to be totally redesigned based on /dev/iommu (see
[RFC 00/20] Introduce /dev/iommu for userspace I/O address space
management).

I will provide some updated kernel and qemu branches for testing purpose
only.

Thanks

Eric
>
> -KR
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
