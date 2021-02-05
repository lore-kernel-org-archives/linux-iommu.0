Return-Path: <SRS0=Vrxx=HH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B08C433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 09:51:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A66C64FBC
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 09:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A66C64FBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 25E5886A9E;
	Fri,  5 Feb 2021 09:51:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id skfYgg-0s9tA; Fri,  5 Feb 2021 09:51:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9288B86A94;
	Fri,  5 Feb 2021 09:51:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86252C08A1;
	Fri,  5 Feb 2021 09:51:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6731BC013A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 09:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 55868872EE
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 09:51:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hvdYq0AV1Ppk for <iommu@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 09:51:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 68C4B870A2
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 09:51:35 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id w4so5466246wmi.4
 for <iommu@lists.linux-foundation.org>; Fri, 05 Feb 2021 01:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=VjKGmSN62P3b8Gz6m1qtw9F99Y61/6CwerUG3tU7MY4=;
 b=hWd/h67FoDG08zJsdEf7THf5fsb8v5CDM+WHa00/AqDgZTi/FJ+XGDpt9noS8j92eT
 c1yHqJWnhx8pzofgcTkG621MIs+ZYNlzfNozMBJ4JGCLPQtNYcZpfLKnYu5xL/x6BT71
 aEdAxyGZOr6ngMqNl+eTVJ0vkLcZMUIAF37j+R6ukekbSONzz5ikB96WW1ggQpbmjh4e
 pzHSlO7VExl5U8GM7ducj2019BOduKzXoVXs1I8Eb0OZbXXoEFER+3Mi9BFjFmjfFpH9
 0gGWV1VKYh/xeHfSCvsqZuEIO8leB844woCNQpyIv7/edOIt3pyLFA5cl+hc11LUi2l0
 BUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VjKGmSN62P3b8Gz6m1qtw9F99Y61/6CwerUG3tU7MY4=;
 b=t/53SGMEfRmrr43F/WtzBbpMmGnoPiV2bMW6MJkMXZlXEVUfAJ4aNZndlDDxjkg2wD
 9U5pf2MSnG5sZygi9njyzW53Yo249k4+9z8FJDn1FVXAOanplNtMJD7PsYrrQmXdSXOS
 uO3/2I+E9BrRBa6sg+tpBDrUIbjHKsUb901eqgoSJMEkCpwnqXEKScLIxT9/GjM6s0H2
 rttFZKELvBmIj2kicsTXsvcgIWleJPKRu9QK0RwLFQvBdvGbxSPEH/TpZbhuksuQHJMx
 C2QjZ+DUvM/nzKKQAdx3O4Bkd53tZ0fJzmV8zGIKg0JXBk1LReVTlnp/o7FAn+htjY5V
 lKxw==
X-Gm-Message-State: AOAM531kxdme9UvBI55KWRPt/6dw4rzi2Tk6fJYrmF3tu58IObU/43os
 8CGj5HOfQRU+uj+xtX5DmkW8ew==
X-Google-Smtp-Source: ABdhPJyBpgLCQ/JhIkBboD0wFrqF+LmtaNQmOXy+bUTKCu4KXYd0D+Ym0BJGOgt45t7ajfN+ikeD0w==
X-Received: by 2002:a1c:7d0c:: with SMTP id y12mr2849282wmc.184.1612518693792; 
 Fri, 05 Feb 2021 01:51:33 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m18sm11669198wrx.17.2021.02.05.01.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Feb 2021 01:51:33 -0800 (PST)
Date: Fri, 5 Feb 2021 10:51:14 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [RFC PATCH 01/11] iommu/arm-smmu-v3: Add feature detection for
 HTTU
Message-ID: <YB0VErwkA0ivRXTd@myrica>
References: <20210128151742.18840-1-zhukeqian1@huawei.com>
 <20210128151742.18840-2-zhukeqian1@huawei.com>
 <f8be5718-d4d9-0565-eaf0-b5a128897d15@arm.com>
 <df1b8fb2-b853-e797-0072-9dbdffc4ff67@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <df1b8fb2-b853-e797-0072-9dbdffc4ff67@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 jiangkunkun@huawei.com, lushenming@huawei.com, linux-kernel@vger.kernel.org,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux-foundation.org,
 James Morse <james.morse@arm.com>, Marc Zyngier <maz@kernel.org>,
 wanghaibin.wang@huawei.com, Robin Murphy <robin.murphy@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Hi Keqian,

On Fri, Feb 05, 2021 at 05:13:50PM +0800, Keqian Zhu wrote:
> > We need to accommodate the firmware override as well if we need this to be meaningful. Jean-Philippe is already carrying a suitable patch in the SVA stack[1].
> Robin, Thanks for pointing it out.
> 
> Jean, I see that the IORT HTTU flag overrides the hardware register info unconditionally. I have some concern about it:
> 
> If the override flag has HTTU but hardware doesn't support it, then driver will use this feature but receive access fault or permission fault from SMMU unexpectedly.
> 1) If IOPF is not supported, then kernel can not work normally.
> 2) If IOPF is supported, kernel will perform useless actions, such as HTTU based dma dirty tracking (this series).
> 
> As the IORT spec doesn't give an explicit explanation for HTTU override, can we comprehend it as a mask for HTTU related hardware register?

To me "Overrides the value of SMMU_IDR0.HTTU" is clear enough: disregard
the value of SMMU_IDR0.HTTU and use the one specified by IORT instead. And
that's both ways, since there is no validity mask for the IORT value: if
there is an IORT table, always ignore SMMU_IDR0.HTTU.

That's how the SMMU driver implements the COHACC bit, which has the same
wording in IORT. So I think we should implement HTTU the same way.

One complication is that there is no equivalent override for device tree.
I think it can be added later if necessary, because unlike IORT it can be
tri state (property not present, overriden positive, overridden negative).

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
