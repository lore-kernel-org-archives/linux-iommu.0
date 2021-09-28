Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2E6C4332F
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 09:23:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71083611CB
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 09:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 71083611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 329B660593;
	Tue, 28 Sep 2021 09:23:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Shu1q01Cc2uq; Tue, 28 Sep 2021 09:23:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0C17D60594;
	Tue, 28 Sep 2021 09:23:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5FDFC000F;
	Tue, 28 Sep 2021 09:23:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C16DC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 09:23:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 888104013C
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 09:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3pVBYpDB6uoc for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 09:23:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC7B940136
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 09:23:47 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id g184so20546326pgc.6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 02:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bNCbpKkDoRa/LEy6AE/asdoXmkV09NnhXW1RxZk9Sdg=;
 b=d7EQaIO2BrzYhwnuLWNgscYrGYoCF1llQTdP7VsnWfHPgbO7X8mwFpRL1rP0sxjRol
 /+BkBsfPxs/6kB2aGGiarfL3uCD04VsP3Qvt0ysEyyh6Gt2+3I1FWrhhioqM5RZZcaaQ
 08hitTmCaLcQBEott0EDr+wFaOq4jqZ1NJtcmmH1pPW9zZ2ctPp9TAkDzkUATz66B0OO
 APGXI2+QPUkq1LfuP1SdBGqjMyXvkbKRa4yN0N3eDg3lv3bc7gcKGRD1XvdkWanbXoPX
 wdfl6sy2mQQiSep/qjiZSaFK4BGckINkhPOtEFqjaiLg960K/wVSLQzxtSjHYSHxv/ie
 tbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bNCbpKkDoRa/LEy6AE/asdoXmkV09NnhXW1RxZk9Sdg=;
 b=m++WiFf8+7BaDxDH9aS3yWM5Qlao7nt0b5MsHRox54v6PCscOWd1cpFW4wZRpSFqXk
 xkOCYOHuu6DbbYcFK7cmV/S0xzbxOgc9A8qCkAORp+Xy4lS5EgYtkGTd/eidFrbGj4SU
 l3HVKg8rjdrwLvnhFT8h78XbOJsbhKUjW8Iy9Ht5x+gcDZ2tM+ij5HchGSDzt61nBlAJ
 Dst7O4A5LtJWwV01rIW+W4wMePatvwLHj10tZwGv1Wdajp14hJsyT5w3yagzx42rnQFj
 4iooAukj0Ix+X9ZW8FdpX+His3v4H8jc4gkFhLp8ayUNryduMW6rvBV4AC0jXCaeqOBB
 7VPA==
X-Gm-Message-State: AOAM5313g6RVb6S0hdWS0x3KBz49c5oBPipvlFu5pMZB9TuoKIG50Q73
 Ragd78Q7c6DuYBlvAcR4mQ0=
X-Google-Smtp-Source: ABdhPJwGWB7Tw6GaWECCuWCSL7zfwRyp/J9yMIqD2mhp7FZqF/2KIG0FGrBjcU+pMCnt5vLHDbzqyg==
X-Received: by 2002:aa7:9f03:0:b0:447:dd09:6dda with SMTP id
 g3-20020aa79f03000000b00447dd096ddamr4300020pfr.36.1632821027229; 
 Tue, 28 Sep 2021 02:23:47 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 mv6sm1943328pjb.16.2021.09.28.02.23.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Sep 2021 02:23:46 -0700 (PDT)
Subject: Re: [PATCH V5 12/12] net: netvsc: Add Isolation VM support for netvsc
 driver
To: Christoph Hellwig <hch@lst.de>
References: <20210914133916.1440931-1-ltykernel@gmail.com>
 <20210914133916.1440931-13-ltykernel@gmail.com>
 <MWHPR21MB15939A5D74CA1DF25EE816ADD7DB9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <43e22b84-7273-4099-42ea-54b06f398650@gmail.com>
 <e379a60b-4d74-9167-983f-f70c96bb279e@gmail.com>
 <20210928053911.GA29208@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <de18b708-7252-642b-c60f-59e12ac27421@gmail.com>
Date: Tue, 28 Sep 2021 17:23:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928053911.GA29208@lst.de>
Content-Language: en-US
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
 "will@kernel.org" <will@kernel.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "x86@kernel.org" <x86@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>, "pgonda@google.com" <pgonda@google.com>,
 "rientjes@google.com" <rientjes@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
 "luto@kernel.org" <luto@kernel.org>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "jgross@suse.com" <jgross@suse.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "tj@kernel.org" <tj@kernel.org>, vkuznets <vkuznets@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
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

On 9/28/2021 1:39 PM, Christoph Hellwig wrote:
> On Mon, Sep 27, 2021 at 10:26:43PM +0800, Tianyu Lan wrote:
>> Hi Christoph:
>>      Gentile ping. The swiotlb and shared memory mapping changes in this
>> patchset needs your reivew. Could you have a look? >
> I'm a little too busy for a review of such a huge patchset right now.
> That being said here are my comments from a very quick review:
Hi Christoph:
       Thanks for your comments. Most patches in the series are Hyper-V
change. I will split patchset and make it easy to review.


> 
>   - the bare memremap usage in swiotlb looks strange and I'd
>     definitively expect a well documented wrapper.

OK. Should the wrapper in the DMA code? How about dma_map_decrypted() 
introduced in the V4?
https://lkml.org/lkml/2021/8/27/605

>   - given that we can now hand out swiotlb memory for coherent mappings
>     we need to carefully audit what happens when this memremaped
>     memory gets mmaped or used through dma_get_sgtable

OK. I check that.

>   - the netscv changes I'm not happy with at all.  A large part of it
>     is that the driver already has a bad structure, but this series
>     is making it significantly worse.  We'll need to find a way
>     to use the proper dma mapping abstractions here.  One option
>     if you want to stick to the double vmapped buffer would be something
>     like using dma_alloc_noncontigous plus a variant of
>     dma_vmap_noncontiguous that takes the shared_gpa_boundary into
>     account.
> 

OK. I will do that.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
