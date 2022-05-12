Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14628C433FE
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 17:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F82F82718;
	Thu, 12 May 2022 17:28:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6fHjQdLOD-kg; Thu, 12 May 2022 17:28:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6ED4182503;
	Thu, 12 May 2022 17:28:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43D31C0039;
	Thu, 12 May 2022 17:28:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 881D8C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 17:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 763E1402C6
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 17:28:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gLDOXnBTSfUa for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 17:28:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64A22409F5
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652376479;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tCD+8lP+xu7DSPBX9O/+vBKxjmnHI/OPG8q73tAYrnQ=;
 b=Q61b+iQ7rLu3HIFJqAStXbCCQ+k0zQbSRRgIiuGw6VxlmlKCKCzn56XCRnPVEBUW9TIrRn
 M1kwFHbycl39m8OXihISmes4BXeeCtHU1DfUio1uXiK2CSno6Scruc7AEc1Jnz7dQJt2o7
 Xhza4eALAnIYsgyCL1byR390JThdS3c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-6vmS73jNMHCiW5yOenaJ1g-1; Thu, 12 May 2022 13:27:51 -0400
X-MC-Unique: 6vmS73jNMHCiW5yOenaJ1g-1
Received: by mail-wm1-f72.google.com with SMTP id
 p24-20020a1c5458000000b003945d2ffc6eso1887921wmi.5
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 10:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=tCD+8lP+xu7DSPBX9O/+vBKxjmnHI/OPG8q73tAYrnQ=;
 b=yhULKAzpM9V0jRTgEl6SX7C6zbjHIhouugAcVJAVySgb/nSPBxCoaC9VujDjBT8j9Q
 tRcV3CEpyliBbByjl+ZYSmciZeubB2ljcaTeW+tM2ozoZXhZ1iJFOEUdheJBQznP2rdN
 a2MFb4ADgyYAJnP5G0qAem0yWAr/yCGKMozgRr/9XunoXCBJlk29zSnB2FlFzsWQyliY
 basrXm8brJcPhu28yq1x+ZRd/WxFc7PB7MQhwBiBpfQq8jOoDa6S3eVzVGha6NpJME39
 ggL6TR0bk8WlvdFJSDbyfiDEaRKH0WgjFiE+nVgC4tDr7/gwVVgC1Haw8ntansKNgoZX
 7y8A==
X-Gm-Message-State: AOAM530vNeJwm+gjmKCm8R555tMc6IHDi56G/1BUCTDV3nEfThsUJemf
 0mjyma61PWp5pKhzIAN7Ut/kM8CupaajmWBiNtUGkgzehQ/C1xD+IDWAfn38LZDFiR2gjaKOX58
 OEAHVvAfnQ7FlhbX6/EZvVS2VQReljw==
X-Received: by 2002:a5d:47a7:0:b0:20c:5b3e:ff7 with SMTP id
 7-20020a5d47a7000000b0020c5b3e0ff7mr683059wrb.362.1652376470552; 
 Thu, 12 May 2022 10:27:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3srJE4qB6x11g/cGuO/5n+uGKjdPkkRDRS6CiXRIBa/uR33ZYaYztU6Mw7Uixet5KfvEsQQ==
X-Received: by 2002:a5d:47a7:0:b0:20c:5b3e:ff7 with SMTP id
 7-20020a5d47a7000000b0020c5b3e0ff7mr683049wrb.362.1652376470345; 
 Thu, 12 May 2022 10:27:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a1ced07000000b0038eba413181sm3361695wmh.1.2022.05.12.10.27.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 May 2022 10:27:49 -0700 (PDT)
Message-ID: <5cdb2ddb-eef1-e522-d41d-7ba0facf6dd7@redhat.com>
Date: Thu, 12 May 2022 19:27:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] vfio: Remove VFIO_TYPE1_NESTING_IOMMU
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
References: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
 <0e2f7cb8-f0d9-8209-6bc2-ca87fff57f1f@arm.com>
 <20220510181327.GM49344@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20220510181327.GM49344@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux-foundation.org,
 Vivek Kumar Gautam <Vivek.Gautam@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

Hi,

On 5/10/22 20:13, Jason Gunthorpe wrote:
> On Tue, May 10, 2022 at 06:52:06PM +0100, Robin Murphy wrote:
>> On 2022-05-10 17:55, Jason Gunthorpe via iommu wrote:
>>> This control causes the ARM SMMU drivers to choose a stage 2
>>> implementation for the IO pagetable (vs the stage 1 usual default),
>>> however this choice has no visible impact to the VFIO user. Further qemu
>>> never implemented this and no other userspace user is known.
>>>
>>> The original description in commit f5c9ecebaf2a ("vfio/iommu_type1: add
>>> new VFIO_TYPE1_NESTING_IOMMU IOMMU type") suggested this was to "provide
>>> SMMU translation services to the guest operating system" however the rest
>>> of the API to set the guest table pointer for the stage 1 was never
>>> completed, or at least never upstreamed, rendering this part useless dead
>>> code.
>>>
>>> Since the current patches to enable nested translation, aka userspace page
>>> tables, rely on iommufd and will not use the enable_nesting()
>>> iommu_domain_op, remove this infrastructure. However, don't cut too deep
>>> into the SMMU drivers for now expecting the iommufd work to pick it up -
>>> we still need to create S2 IO page tables.
>>>
>>> Remove VFIO_TYPE1_NESTING_IOMMU and everything under it including the
>>> enable_nesting iommu_domain_op.
>>>
>>> Just in-case there is some userspace using this continue to treat
>>> requesting it as a NOP, but do not advertise support any more.
>> I assume the nested translation/guest SVA patches that Eric and Vivek were
>> working on pre-IOMMUFD made use of this, and given that they got quite far
>> along, I wouldn't be too surprised if some eager cloud vendors might have
>> even deployed something based on the patches off the list. 

thank you Robin for the heads up.
> With upstream there is no way to make use of this flag, if someone is
> using it they have other out of tree kernel, vfio, kvm and qemu
> patches to make it all work.
>
> You can see how much is still needed in Eric's tree:
>
> https://github.com/eauger/linux/commits/v5.15-rc7-nested-v16
>
>> I can't help feeling a little wary about removing this until IOMMUFD
>> can actually offer a functional replacement - is it in the way of
>> anything upcoming?
> From an upstream perspective if someone has a patched kernel to
> complete the feature, then they can patch this part in as well, we
> should not carry dead code like this in the kernel and in the uapi.

On the other end the code is in the kernel for 8 years now, I think we
could wait for some additional weeks/months until the iommufd nested
integration arises and gets tested.

Thanks

Eric
>
> It is not directly in the way, but this needs to get done at some
> point, I'd rather just get it out of the way.
>
> Thanks,
> Jason
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
