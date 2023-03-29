Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C5AFE1
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 12:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1680093395; x=1711629395;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=9BIVQAV7qt8Ug8zbs5YPptmgYpUt2pDKa6KaSVzh8Lo=;
  b=a9038OSkNjt2qA4a+dva/dEyJjc5lAa/96U0RXkxx4Az5ZUpHrVmLpRl
   Kx8LjCD81FXKlFfdvs5ZKm5flcWPE61sFVean7AzqAuO0CHNYWXcN88j7
   N5R47ekTCwHgttdCZBmwJ/19IaOu3YifZEw/Ni9b7IQbtWyspWmZuyRlM
   4=;
X-IronPort-AV: E=Sophos;i="5.98,300,1673913600"; 
   d="scan'208";a="1117495953"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 12:36:28 +0000
Received: from EX19D020EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com (Postfix) with ESMTPS id 2FBF7A02EB;
	Wed, 29 Mar 2023 12:36:28 +0000 (UTC)
Received: from EX19D030EUC004.ant.amazon.com (10.252.61.164) by
 EX19D020EUA004.ant.amazon.com (10.252.50.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 Mar 2023 12:36:27 +0000
Received: from EX19D030EUC004.ant.amazon.com (10.252.61.164) by
 EX19D030EUC004.ant.amazon.com (10.252.61.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.26;
 Wed, 29 Mar 2023 12:36:26 +0000
Received: from EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477]) by
 EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477%3]) with mapi id
 15.02.1118.026; Wed, 29 Mar 2023 12:36:26 +0000
From: "Krcka, Tomas" <krckatom@amazon.de>
To: Will Deacon <will@kernel.org>
CC: "Krcka, Tomas" <krckatom@amazon.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Shameer
 Kolothum" <shameerali.kolothum.thodi@huawei.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix event queue overflow
 acknowledgment
Thread-Topic: [PATCH] iommu/arm-smmu-v3: Fix event queue overflow
 acknowledgment
Thread-Index: AQHZYjsUJTyLbHuMvUep4ekJH0WoLQ==
Date: Wed, 29 Mar 2023 12:36:26 +0000
Message-ID: <BD6629C9-7E59-43B1-BE58-F6799E0FBC5E@amazon.com>
References: <20230308092048.71390-1-krckatom@amazon.de>
 <20230327121234.GA31342@willie-the-truck>
 <8845FA6A-45F1-4090-B4A2-C0C28F709095@amazon.com>
 <20230328115613.GB1159@willie-the-truck>
In-Reply-To: <20230328115613.GB1159@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.213.23]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C71BB1ED14D3C5439E0FD0B680DF4439@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> On 28. Mar 2023, at 13:56, Will Deacon <will@kernel.org> wrote:
> =

> =

> On Tue, Mar 28, 2023 at 07:13:52AM +0000, Krcka, Tomas wrote:
>> =

>>> On 27. Mar 2023, at 14:12, Will Deacon <will@kernel.org> wrote:
>>> =

>>> =

>>> On Wed, Mar 08, 2023 at 09:20:47AM +0000, Tomas Krcka wrote:
>>>> When an overflow occurs in the event queue, the SMMU toggles overflow
>>>> flag OVFLG in the PROD register.
>>>> The evtq thread is supposed to acknowledge the overflow flag by toggli=
ng
>>>> flag OVACKFLG in the CONS register, otherwise the overflow condition is
>>>> still active (OVFLG !=3D OVACKFLG).
>>>> =

>>>> Currently the acknowledge register is toggled after clearing the event
>>>> queue but is never propagated to the hardware. It would be done next
>>>> time when executing evtq thread.
>>>> =

>>>> The SMMU still adds elements to the queue when the overflow condition =
is
>>>> active but any subsequent overflow information after clearing the event
>>>> queue will be lost.
>>>> =

>>>> This change keeps the SMMU in sync as it's expected by design.
>>>> =

>>>> Signed-off-by: Tomas Krcka <krckatom@amazon.de>
>>>> Suggested-by: KarimAllah Ahmed <karahmed@amazon.de>
>>>> ---
>>>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>> =

>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iom=
mu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> index f2425b0f0cd6..acc1ff5ff69b 100644
>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> @@ -1579,6 +1579,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq,=
 void *dev)
>>>>     /* Sync our overflow flag, as we believe we're up to speed */
>>>>     llq->cons =3D Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
>>>>                 Q_IDX(llq, llq->cons);
>>>> +     queue_sync_cons_out(q);
>>>>     return IRQ_HANDLED;
>>>> }
>>> =

>>> I think I probably did mean to have something like this, but can we
>>> only do the actual h/w update if overflow has occurred? Otherwise I thi=
nk
>>> we're pointlessly writing back the same value most of the time.
>>> =

>>> Will
>> =

>> Yes, we can, but then same applies for the priq as well, there we also w=
rite back
>> every time.
> =

> Sure, feel free to update both.
> =


OK, I sent it as new patch: https://lore.kernel.org/lkml/20230329123420.346=
41-1-tomas.krcka@gmail.com





Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



