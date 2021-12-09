Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E105C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 16:38:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD476856FF;
	Thu,  9 Dec 2021 16:38:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YcTVXwJgtHAk; Thu,  9 Dec 2021 16:38:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AF46D85703;
	Thu,  9 Dec 2021 16:38:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B596C002F;
	Thu,  9 Dec 2021 16:38:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85A80C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 731F561AFC
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id scIdcziZ6yTH for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 16:38:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDD6661AF7
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 16:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639067885;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jNxrSJ7hA39700PK5sP9nWrntBLNr8e9xNebTOGiU18=;
 b=cc6amfx1wjns0lW/pftbf06z9IcWvmiBDtjhmQD6PHQpKyegX3e+T5/8suraCw2wAaEkRm
 l0HTkHZStu8qkrEovZJxoRJMYfDjuZU0rYPZXmZb4ATxp6xccbInk95B1A7sN7RrxGDn7e
 XlJ21b8vQva3VBAbx/hd5tGPZWQlveQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-KM7zJ7-dMYegZfD8qf15pQ-1; Thu, 09 Dec 2021 11:38:02 -0500
X-MC-Unique: KM7zJ7-dMYegZfD8qf15pQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 g81-20020a1c9d54000000b003330e488323so2181130wme.0
 for <iommu@lists.linux-foundation.org>; Thu, 09 Dec 2021 08:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=jNxrSJ7hA39700PK5sP9nWrntBLNr8e9xNebTOGiU18=;
 b=R0Heou8NdUuc5AFsvr/xx1tsiqLYGhO4d8d5zwWf/YG1IgySbbsCL0zZUTF5cUu3O9
 67MiaU8YMA+PjteOSkm0Tn+Nt6ggORWhHjpJl4kyb4dgqsTAiD8H6BSzggiwVPcxIOam
 ldMOa2s+2bSeGArKLAdlMpegD1GiagLciPddoBo+TnmyjSbiinlTMjjF/s9kyhqjS4OE
 mZE5CNEg1KZ32zJnUdnMXiU+5lJ1S22BG2Uaa+MjulwZk/Rnc7GP7OvaY09aENB6Vra+
 BJY9gf0wUfdMU9/MjzX6BqJ079G8xpNN+xmS/D4CgZej4MVLglS5945N7itYkDsGlrH+
 aZbA==
X-Gm-Message-State: AOAM531dy9FL1Yg2LFaD8wYi4bvI4cjd0Q4/f1oSSxewlsYiRTKY4RAB
 oLMqKXe7065VRR1Wxrj6I3IvaUqotyWQfs8kHsyGXoNzdN4+LiLmuYXxmhG7u/uMErPU8QMHezN
 E0xLO4YNAEWg1Oy5fcyGVMy9jnIPZTg==
X-Received: by 2002:a5d:58ed:: with SMTP id f13mr7636101wrd.373.1639067881501; 
 Thu, 09 Dec 2021 08:38:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaV0R+9HzYiSu0FZYalbofmj5ndV0Ij51Jvm3EMXiekkqz6rpjx+QrGmfxHOtUjUM3LxbGgQ==
X-Received: by 2002:a5d:58ed:: with SMTP id f13mr7636061wrd.373.1639067881306; 
 Thu, 09 Dec 2021 08:38:01 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id d7sm163025wrw.87.2021.12.09.08.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 08:38:00 -0800 (PST)
Subject: Re: [RFC v16 1/9] iommu: Introduce attach/detach_pasid_table API
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20211027104428.1059740-1-eric.auger@redhat.com>
 <20211027104428.1059740-2-eric.auger@redhat.com>
 <Ya3qd6mT/DpceSm8@8bytes.org>
 <c7e26722-f78c-a93f-c425-63413aa33dde@redhat.com>
 <e6733c59-ffcb-74d4-af26-273c1ae8ce68@linux.intel.com>
 <fbeabcff-a6d4-dcc5-6687-7b32d6358fe3@redhat.com>
 <20211208125616.GN6385@nvidia.com> <YbDpZ0pf7XeZcc7z@myrica>
 <20211208183102.GD6385@nvidia.com>
 <b576084b-482f-bcb7-35a6-d786dbb305e1@redhat.com>
 <20211209154046.GQ6385@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <f6e93350-e0ee-649a-bf97-314398481fc8@redhat.com>
Date: Thu, 9 Dec 2021 17:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211209154046.GQ6385@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, lushenming@huawei.com,
 robin.murphy@arm.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, maz@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vsethi@nvidia.com, vivek.gautam@arm.com, alex.williamson@redhat.com,
 wangxingang5@huawei.com, zhangfei.gao@linaro.org, eric.auger.pro@gmail.com,
 will@kernel.org, kvmarm@lists.cs.columbia.edu
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

Hi Jason,

On 12/9/21 4:40 PM, Jason Gunthorpe wrote:
> On Thu, Dec 09, 2021 at 08:50:04AM +0100, Eric Auger wrote:
>
>>> The kernel API should accept the S1ContextPtr IPA and all the parts of
>>> the STE that relate to the defining the layout of what the S1Context
>>> points to an thats it.
>> Yes that's exactly what is done currently. At config time the host must
>> trap guest STE changes (format and S1ContextPtr) and "incorporate" those
>> changes into the stage2 related STE information. The STE is owned by the
>> host kernel as it contains the stage2 information (S2TTB).
> [..]
>
>> Note this series only coped with a single CD in the Context Descriptor
>> Table.
> I'm confused, where does this limit arise?
>
> The kernel accepts as input all the bits in the STE that describe the
> layout of the CDT owned by userspace, shouldn't userspace be able to
> construct all forms of CDT with any number of CDs in them?
>
> Or do you mean this is some qemu limitation?
The upstream vSMMUv3 emulation does not support multiple CDs at the
moment and since I have no proper means to validate the vSVA case I am
rejecting any attempt from user space to inject guest configs featuring
mutliple PASIDs. Also PASID cache invalidation must be added to this series.

Nevertheless those limitations were tackled and overcomed by others in
CC so I don't think there is any blocking issue.

Thanks

Eric
>
> Jason
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
