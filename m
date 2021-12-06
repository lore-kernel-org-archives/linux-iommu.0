Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645D5C43217
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 14:19:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B0E64092C;
	Mon,  6 Dec 2021 14:19:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oFdh3Q8Ta9d8; Mon,  6 Dec 2021 14:19:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C6B3540924;
	Mon,  6 Dec 2021 14:19:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A20E1C001E;
	Mon,  6 Dec 2021 14:19:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B96BC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:19:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DFDF6079A
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:19:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Exn2U0pzN9O0 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 14:19:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D76560598
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:19:33 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 n15-20020a17090a160f00b001a75089daa3so10946829pja.1
 for <iommu@lists.linux-foundation.org>; Mon, 06 Dec 2021 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=7+TjBg26qYjN6N7+9VcAF9zyslm2ABiWax4bLutA+tA=;
 b=f9M5JLJRG6hZFPCcZ1VGBj6dk4h92i9GiiVgKsNNUQFiDTSIXmaER9IaQWziUfrQ/0
 qa3GNaf/njTkL1uJ81a318oppGqxeZ4BbcT9GGYMjs1cw8PHMlBEDdFp5Gu7W2ZYhqeP
 DQ0dE5SsoRhc/sIPqjG5IRHWnrHc+0w5hEjT3ppnETiBZyKvJyuh5hygqrwyVBhoEnmJ
 IwRmbyJ5sNomLrxjpRo1y9wtWt2MJXEM2X247X8t1UvJ2rV20IbyXdb2S1lE9i34MGPO
 C7yQKcwPzpoDJz5kk+NMg8L4gzvSsI27nnr11s1xyG3B7cafIHH1YyJFJ5x78gBD3amG
 bCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7+TjBg26qYjN6N7+9VcAF9zyslm2ABiWax4bLutA+tA=;
 b=cGlpJhgh4/ZdtrfB9EjNA7aVmzGSv7Lpzffhy5sspUPlC0mkct25YhLWUSCs4RGdLJ
 QCe4KTYAWtpBW9pi/dHm6eOJAk0lOnTQ8w234+KZSjh+cxVM9HUVHQfNBwSLkmnha2C/
 hAEWlW6q/eHVzi8VA6+KviYh417jJ+UPj84aCn9A1uXsvPuXM/IZi6KoV3dut6dxnQAC
 gMHNz1RO/aBEXzi6aXXeU0qz44H844074o+q+LcNNEjWKTX6AuimDmI9ot19Sj3Ibk0F
 E11CJlkYrFubIwmQ5Fp1Lq11CVUnRYGeOPFrJ+6r2qoF5TaHRpPSu5eX9awbMPREKYTU
 y23g==
X-Gm-Message-State: AOAM532LlTS1u8eamA03PpIMKpmDlZTcxoaFm5n7B+waMHW9DNMzNBYu
 QeDsAka1182g934TdgMy3Yw=
X-Google-Smtp-Source: ABdhPJw5eBcqMnlmCu3VP7SDK7JlPHBF3sS/6sU5CfZhorAn8F+Tm/Z37W+b1RJF7S8Gmv/jOQFzmw==
X-Received: by 2002:a17:90b:4b51:: with SMTP id
 mi17mr37838716pjb.48.1638800372941; 
 Mon, 06 Dec 2021 06:19:32 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 h1sm3517800pfh.219.2021.12.06.06.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Dec 2021 06:19:32 -0800 (PST)
Message-ID: <581569ce-b166-1cad-2624-66de319cc2b9@gmail.com>
Date: Mon, 6 Dec 2021 22:19:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 3/5] hyperv/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
Content-Language: en-US
To: Juergen Gross <jgross@suse.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 sstabellini@kernel.org, boris.ostrovsky@oracle.com, joro@8bytes.org,
 will@kernel.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, xen-devel@lists.xenproject.org,
 michael.h.kelley@microsoft.com
References: <20211205081815.129276-1-ltykernel@gmail.com>
 <20211205081815.129276-4-ltykernel@gmail.com>
 <a5943893-510a-3fc8-cbb7-8742369bf36b@suse.com>
 <125ffb7d-958c-e77a-243b-4cf38f690396@gmail.com>
 <ed9aa3d5-9ac8-2195-e617-85599ffd7864@suse.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <ed9aa3d5-9ac8-2195-e617-85599ffd7864@suse.com>
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com, hch@lst.de
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



On 12/5/2021 6:31 PM, Juergen Gross wrote:
> On 05.12.21 09:48, Tianyu Lan wrote:
>>
>>
>> On 12/5/2021 4:34 PM, Juergen Gross wrote:
>>> On 05.12.21 09:18, Tianyu Lan wrote:
>>>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>>>
>>>> hyperv Isolation VM requires bounce buffer support to copy
>>>> data from/to encrypted memory and so enable swiotlb force
>>>> mode to use swiotlb bounce buffer for DMA transaction.
>>>>
>>>> In Isolation VM with AMD SEV, the bounce buffer needs to be
>>>> accessed via extra address space which is above shared_gpa_boundary
>>>> (E.G 39 bit address line) reported by Hyper-V CPUID ISOLATION_CONFIG.
>>>> The access physical address will be original physical address +
>>>> shared_gpa_boundary. The shared_gpa_boundary in the AMD SEV SNP
>>>> spec is called virtual top of memory(vTOM). Memory addresses below
>>>> vTOM are automatically treated as private while memory above
>>>> vTOM is treated as shared.
>>>>
>>>> Hyper-V initalizes swiotlb bounce buffer and default swiotlb
>>>> needs to be disabled. pci_swiotlb_detect_override() and
>>>> pci_swiotlb_detect_4gb() enable the default one. To override
>>>> the setting, hyperv_swiotlb_detect() needs to run before
>>>> these detect functions which depends on the pci_xen_swiotlb_
>>>> init(). Make pci_xen_swiotlb_init() depends on the hyperv_swiotlb
>>>> _detect() to keep the order.
>>>
>>> Why? Does Hyper-V plan to support Xen PV guests? If not, I don't see
>>> the need for adding this change.
>>>
>>
>> This is to keep detect function calling order that Hyper-V detect 
>> callback needs to call before pci_swiotlb_detect_override() and 
>> pci_swiotlb_detect_4gb(). This is the same for why
>> pci_swiotlb_detect_override() needs to depend on the 
>> pci_xen_swiotlb_detect(). Hyper-V also has such request and so make 
>> xen detect callback depends on Hyper-V one.
> 
> And does this even work without CONFIG_SWIOTLB_XEN, i.e. without
> pci_xen_swiotlb_detect() being in the system?
> 
Hi Juergen:
	Thanks for your review. This is a issue and I just sent out a v5 which 
decouples the dependency between xen and hyperv.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
