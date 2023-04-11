Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5A2F21
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 21:22:57 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-198-g5syxxZ0PvepsyDefepPNQ-1; Tue, 11 Apr 2023 22:22:54 +0100
X-MC-Unique: g5syxxZ0PvepsyDefepPNQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 11 Apr
 2023 22:22:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 11 Apr 2023 22:22:52 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Lu Baolu' <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC: Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Thread-Topic: [PATCH 11/17] iommu/vt-d: Fix operand size in bitwise operation
Thread-Index: AQHZbEHu9QGkmONo40W+xGFseOdGmq8mnrSg
Date: Tue, 11 Apr 2023 21:22:52 +0000
Message-ID: <ec1536af68e6478a9b10a0d884cc988d@AcuMS.aculab.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
 <20230411064815.31456-12-baolu.lu@linux.intel.com>
In-Reply-To: <20230411064815.31456-12-baolu.lu@linux.intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Lu Baolu
> Sent: 11 April 2023 07:48
>=20
> From: Tina Zhang <tina.zhang@intel.com>
>=20
> The patch fixes the klocwork issues that operands in a bitwise operation
> have different size at line 1692 of dmar.c, line 1898 and line 1907 of
> iommu.c.

Why is this any kind of thing that needs fixing?

=09David

> Reported-by: Yongwei Ma <yongwei.ma@intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> Link: https://lore.kernel.org/r/20230406065944.2773296-2-tina.zhang@intel=
.com
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c  | 2 +-
>  drivers/iommu/intel/iommu.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 23828d189c2a..f0f51c957ccb 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1690,7 +1690,7 @@ static void __dmar_enable_qi(struct intel_iommu *io=
mmu)
>  =09 * is present.
>  =09 */
>  =09if (ecap_smts(iommu->ecap))
> -=09=09val |=3D (1 << 11) | 1;
> +=09=09val |=3D BIT_ULL(11) | BIT_ULL(0);
>=20
>  =09raw_spin_lock_irqsave(&iommu->register_lock, flags);
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index f4e536fd5a28..acbf82fa90e7 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1870,7 +1870,7 @@ context_set_sm_rid2pasid(struct context_entry *cont=
ext, unsigned long pasid)
>   */
>  static inline void context_set_sm_dte(struct context_entry *context)
>  {
> -=09context->lo |=3D (1 << 2);
> +=09context->lo |=3D BIT_ULL(2);
>  }
>=20
>  /*
> @@ -1879,7 +1879,7 @@ static inline void context_set_sm_dte(struct contex=
t_entry *context)
>   */
>  static inline void context_set_sm_pre(struct context_entry *context)
>  {
> -=09context->lo |=3D (1 << 4);
> +=09context->lo |=3D BIT_ULL(4);
>  }
>=20
>  /* Convert value to context PASID directory size field coding. */
> --
> 2.34.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

