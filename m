Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF24EBB
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 07:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1679987639; x=1711523639;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=cs515H+pAY5a8BjNWqt1o2h2IfKbYZ5CffOpLSxnAZU=;
  b=LgFrmR6E+lck5soCo2CpA0FdWgr3oY5g0bb0JC/o9F8cxcmZqAbYXsIf
   s6WpXBD3YxUvdox/FTwi6IxLf45gKQXkqb8bLpR3cGf+WDi3W2Rcl0Rdr
   97NUMCOJbsaW+ErDtCzdubZOXeVwBX4/rt4zOuThLSIzjgLnEJvhHlkk/
   s=;
X-IronPort-AV: E=Sophos;i="5.98,296,1673913600"; 
   d="scan'208";a="198148107"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 07:13:56 +0000
Received: from EX19D012EUA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com (Postfix) with ESMTPS id 8D44780C82;
	Tue, 28 Mar 2023 07:13:53 +0000 (UTC)
Received: from EX19D030EUC003.ant.amazon.com (10.252.61.173) by
 EX19D012EUA002.ant.amazon.com (10.252.50.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 28 Mar 2023 07:13:53 +0000
Received: from EX19D030EUC004.ant.amazon.com (10.252.61.164) by
 EX19D030EUC003.ant.amazon.com (10.252.61.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.26;
 Tue, 28 Mar 2023 07:13:52 +0000
Received: from EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477]) by
 EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477%3]) with mapi id
 15.02.1118.026; Tue, 28 Mar 2023 07:13:52 +0000
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
Thread-Index: AQHZYUTaFwYdqW+H5UaPJVsYwN0JvQ==
Date: Tue, 28 Mar 2023 07:13:52 +0000
Message-ID: <8845FA6A-45F1-4090-B4A2-C0C28F709095@amazon.com>
References: <20230308092048.71390-1-krckatom@amazon.de>
 <20230327121234.GA31342@willie-the-truck>
In-Reply-To: <20230327121234.GA31342@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.212.24]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC8E623EC41C2C43AD633B3F532E78AE@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


> On 27. Mar 2023, at 14:12, Will Deacon <will@kernel.org> wrote:
> =

> =

> On Wed, Mar 08, 2023 at 09:20:47AM +0000, Tomas Krcka wrote:
>> When an overflow occurs in the event queue, the SMMU toggles overflow
>> flag OVFLG in the PROD register.
>> The evtq thread is supposed to acknowledge the overflow flag by toggling
>> flag OVACKFLG in the CONS register, otherwise the overflow condition is
>> still active (OVFLG !=3D OVACKFLG).
>> =

>> Currently the acknowledge register is toggled after clearing the event
>> queue but is never propagated to the hardware. It would be done next
>> time when executing evtq thread.
>> =

>> The SMMU still adds elements to the queue when the overflow condition is
>> active but any subsequent overflow information after clearing the event
>> queue will be lost.
>> =

>> This change keeps the SMMU in sync as it's expected by design.
>> =

>> Signed-off-by: Tomas Krcka <krckatom@amazon.de>
>> Suggested-by: KarimAllah Ahmed <karahmed@amazon.de>
>> ---
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>> 1 file changed, 1 insertion(+)
>> =

>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu=
/arm/arm-smmu-v3/arm-smmu-v3.c
>> index f2425b0f0cd6..acc1ff5ff69b 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -1579,6 +1579,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, v=
oid *dev)
>>      /* Sync our overflow flag, as we believe we're up to speed */
>>      llq->cons =3D Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
>>                  Q_IDX(llq, llq->cons);
>> +     queue_sync_cons_out(q);
>>      return IRQ_HANDLED;
>> }
> =

> I think I probably did mean to have something like this, but can we
> only do the actual h/w update if overflow has occurred? Otherwise I think
> we're pointlessly writing back the same value most of the time.
> =

> Will

Yes, we can, but then same applies for the priq as well, there we also writ=
e back
every time.

Tomas



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



