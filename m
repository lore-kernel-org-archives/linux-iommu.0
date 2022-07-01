Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04C3C1E
	for <iommu@lists.linux.dev>; Fri,  1 Jul 2022 16:13:48 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id ay16so4912363ejb.6
        for <iommu@lists.linux.dev>; Fri, 01 Jul 2022 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fmpoE3SOxYGWE+UCHZpRNu+aOmNCjiBhQz/RLU3kMgM=;
        b=qJk6VJJcSU7isiM5qXM+sSU4s/LlKTET2BRCOqWrJIqxxh/i3lPC7pfHcyhMy+btU+
         g5n+l6B2zEXXP8cSrA9forQxxsIT41YfSI9xAlHmPO3yGqR/8H++2vtHX7XmJAnHlQD1
         9fNm5fDQV5+OonmZesiVvE4l5AUtWzvZ3ewhgmnsGL1nfMinckdK7NXALm7l2mCfo+oP
         rqLfeuNYXtDP3GOKQ09P/lcUObHjjfmsIZcFrLEY7rqGB0BaqD2lZaCFlt7MnY3d5MB4
         zox+hrKu84JY41U+bgJjNd4tRsqQ1qPSp1uIlMGJRPZ0Nf7YN+xKrcPMTIKqxyeoy7ZB
         n7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fmpoE3SOxYGWE+UCHZpRNu+aOmNCjiBhQz/RLU3kMgM=;
        b=pjeNW4csFLBjnKaG/hY1RN0zCIL02rjno+HHHBXeHa+Xj2URDPx1dy9Wc594+zkiUf
         hlKSgwf6jbjHHQ4BfCn/bcJfwMjsjG+1GzdSFcXF6r9b2vOw61brz8BpDlSOGi2FTQN7
         AkPuco8T4woFxvsPUv+e3/Ppq3GAekR3fAnf9VjCB+o5KiRXzMUGwb1WyT7ZnODl38YH
         gBpzvf7meb0Se9rbeQc0aNlkBSFHlkYItd9XgAgr9IBiNlaOWnlJdwGcntqxuNOzkkBE
         GadXGkYvyIR8eTPiwkelLYlPKwPlp6VvhhYHLPYJbPCbbBcavZj3P1IP28n+Cc3VAwHB
         H3UQ==
X-Gm-Message-State: AJIora9xjFAZDUVcqV8nlaWAppxb7lp8gCC7YpvSX931+yutC09Iy6b7
	HOWBCfSUfbVb7fGbWPcMx6M=
X-Google-Smtp-Source: AGRyM1sz1O6/fl0Ea97Sugobh0As/pTf+zl7GKY+/4ILQ5LqMP8NXQlvG/BhAH8xe+n8+2hAfZwTNA==
X-Received: by 2002:a17:907:7f90:b0:726:e8ed:3c28 with SMTP id qk16-20020a1709077f9000b00726e8ed3c28mr15294148ejc.63.1656692027029;
        Fri, 01 Jul 2022 09:13:47 -0700 (PDT)
Received: from [192.168.1.10] (adsl-146.37.6.170.tellas.gr. [37.6.170.146])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709060c0a00b0070beb9401d9sm10689704ejf.171.2022.07.01.09.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 09:13:46 -0700 (PDT)
Message-ID: <d74cb4e1-e504-75be-f46c-aac1115cdc55@gmail.com>
Date: Fri, 1 Jul 2022 19:13:43 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix undefined behavior in GBPA_UPDATE
Content-Language: en-US
To: Will Deacon <will@kernel.org>
Cc: joro@8bytes.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220630063959.27226-1-burzalodowa@gmail.com>
 <20220701143401.GA28408@willie-the-truck>
From: xenia <burzalodowa@gmail.com>
In-Reply-To: <20220701143401.GA28408@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <20220701161343.rhzZvKEOja8Sm-iwahAMyWsMBayRkW0n0-DNDhhOaiM@z>

On 7/1/22 17:34, Will Deacon wrote:
> On Thu, Jun 30, 2022 at 09:39:59AM +0300, Xenia Ragiadakou wrote:
>> The expression 1 << 31 results in undefined behaviour because the type of
>> integer constant 1 is (signed) int and the result of shifting 1 by 31 bits
>> is not representable in the (signed) int type.
>>
>> Change the type of 1 to unsigned int by adding the U suffix.
>>
>> Signed-off-by: Xenia Ragiadakou <burzalodowa@gmail.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index cd48590ada30..44fbd499edea 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -96,7 +96,7 @@
>>   #define CR2_E2H				(1 << 0)
>>   
>>   #define ARM_SMMU_GBPA			0x44
>> -#define GBPA_UPDATE			(1 << 31)
>> +#define GBPA_UPDATE			(1U << 31)
> There are loads of these kicking around in the kernel sources and we compile
> with -fno-strict-overflow.
>
> If you really want to change these, then let's use the BIT() macro instead,
> but I think it's really just churn.
>
> Will
Hi Will,

I thought that since in commit 587e6c10a7ce89a5924fdbeff2ec524fbd6a124b 
there was a similar fix to Q_OVERFLOW_FLAG (see below)

--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -183,7 +183,7 @@

  #define Q_IDX(llq, p)                  ((p) & ((1 << 
(llq)->max_n_shift) - 1))
  #define Q_WRP(llq, p)                  ((p) & (1 << (llq)->max_n_shift))
-#define Q_OVERFLOW_FLAG                        (1 << 31)
+#define Q_OVERFLOW_FLAG                        (1U << 31)
  #define Q_OVF(p)                       ((p) & Q_OVERFLOW_FLAG)
  #define Q_ENT(q, p)                    ((q)->base +                    \
                                          Q_IDX(&((q)->llq), p) *        \

then it would make sense to fix GBPA_UPDATE in the same way.

Xenia

