Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AF6320A;
	Thu, 20 Apr 2023 08:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681977983; x=1713513983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gyth8q1xpujjZ/lzJKpxjOoSNfUbb5+mzbpjZG/mm+E=;
  b=lywyeX0O0tlkdUBzXHdWXclDH6yKrkDsHFn+ItFDN0p1Sk4P5l1TYC8n
   V/DhXC8osQAH4+M4JbcDE0QAA/fBpVyHGQ3FeD46rgf2oOSiV8v3NNDzf
   YiCD03yDNvbOhX/hNK8oJPSyxcXQ2o67+kO6JPRWS92YUyFQhW5zPpGDI
   skckyvAxB9ig3W31emc3fxPhiFD7MfMrSZEM4KYkl6DOpb5Fb/dfhTCDc
   EhV0cbXnqaQcpYQvdk0v9ltjTMABILu4aukxTQQxh9WPSdacxjvAyGUwR
   dTziV1C9kvnRMyVNJmVCgh7nsxQ2Sc9pcNsxU5Kuq8wn56P74VqTxMGvL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="410905089"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="410905089"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="761058707"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="761058707"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2023 01:06:22 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 01:06:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 01:06:20 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 01:06:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkCncHJAkARWiQOU6/Xt6UnYhYL7K6dWDY13MCtgzdr4CP00/fwGtChnbQIDWOb/8bEQSYKv6lYCZGf+BI6jdaj+QLHW2if8NgvtRhtIGx4V8PfCClHXqI2eXZ97JKwyAiAe6aX5ovI75aCkzAsZ/i/HxwWEpfKKI4letFOIA3n7VsPB7UFBnphsk0N7CRaKnpJ84opROZLd/ElgGLONC4+Sn23yJTRwnyFwIanRtQONS8GHwYLhcQYyKKFm54pWI3OfNB0vC3kiE/SyviAHRXOLiqNgCbAFbZtQKVXVvBAYQPo/g48lCUhETuPXHVbFlpQu1e0YLFmhyXd5AQek9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ket5MZL9RSHxCXUUmDIkZvEPJob3h7LzzO39NZJrzgM=;
 b=H0BmVnRchu1M5Pa8VkFCdPONBwhliY8M97v+V0lbHFfIBAh5TnvXshuOr6bTRKDT78HUrXngTrxCRJNv5GjdG/xWPFAcnhN6yXDAI4CXhPAQW5xMA1Zfa3ioRtiB2VlZ4su+FQIt/3NBi1Nm+hvjDGaO2d0uMMkSq5UXUB4iO1AfiexMsnGJZtf6lunrQ3kEBIA9KafFLAv5Se1Jn+ImTLYowk3yh0ytZ1Ppb234Ahngb0alLxI2U5D9MI+KvXoe9F8e4BD8ddDB6nY51Dkh8ECWhr6+j59koZdAV9RAPn5orN1BCUtAu20CKn2B5Efmm7Cn4NDy6PPhbqy0l0JOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SJ1PR11MB6300.namprd11.prod.outlook.com (2603:10b6:a03:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 08:06:17 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f%8]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 08:06:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 16/17] iommu: Remove __iommu_group_for_each_dev()
Thread-Topic: [PATCH v4 16/17] iommu: Remove __iommu_group_for_each_dev()
Thread-Index: AQHZbUX1e5P+8wSfbUq6KqnnC2Foza8z4rIQ
Date: Thu, 20 Apr 2023 08:06:17 +0000
Message-ID: <BL1PR11MB5271BBE89526DA4E3DBEEF2F8C639@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <16-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <16-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SJ1PR11MB6300:EE_
x-ms-office365-filtering-correlation-id: 84a40e28-6755-4996-6a1c-08db41761e78
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qKzx8UPp53mC6sYfAEKCY33w5hNg0OOIVYHmUnpXLrPozVIxEGsKZ98u61f2AyQenOo/G/c7YnpCDC0d01zGvyY4WFOo47m36SySiD5W/n4magfqs+NB18QMUVuZuRENBb53q4932dKdaQNWLVmkWCrAxl/bdj0z8TlPWD2cyBesAS0Nsmn6rnNY2flSN0yZOlWpG3GWRlvkergFpXkBXUDoPDSN6zJQz4do4P9Xc5vw3YIUDCwX2PVuBKumTF/J+YdRIgeTsyQBffpUwZ6quKd9ponn59qD0CApgBtRrqunKhWfTWIbrOX+7sUXbAPjjXpxudOl1ualT1HzMHUK9oHZig64izVs5eESCyO2JILI2fh1GxPRULNJFwJgcCuCK+9oimoJo1EkZr1A/s/S7BK8SXTmmhITyf/uxzQYin3B/o8mMBrtLdER62EUXlTlXI8Vvyb9USwnnkm/zkpujudU/gmqbwNAE6iQ4fMXpN+Tc3jaX26+96C+pQGLNSfM4URzlOFu1SXSVCfEOTCRbA1Mt1tAG/owvZftJ52wIKFaLd2nKJfX1KpkGyTFtHh2kOfyGRRkCDiO1c/SKmilyR+qHeVqE+ioOFUqTCWC/C0u5ZffyCJWCmfDBJfHXDV//ZUIPCpN20JisG4YEdRbdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(122000001)(4326008)(316002)(54906003)(110136005)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(186003)(6506007)(26005)(9686003)(38100700002)(83380400001)(5660300002)(41300700001)(8676002)(55016003)(8936002)(478600001)(7696005)(71200400001)(38070700005)(33656002)(86362001)(2906002)(7416002)(52536014)(82960400001)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q7EPMQ+KgYeZ7/JQlK96YQ3MUve0FV+8AJ1lhv3Zy7ou2UPb951ltVZVSXHO?=
 =?us-ascii?Q?YM30RFGXGiFKG2poZEpqjgkJlTuaIUhws/eg/6KdRlaoruoM+kG5ae31BfRR?=
 =?us-ascii?Q?ZpQoX9Slk2F/w6ISE7ARa+HI6n/8p46nLo9VV6i4WXRJe4qBxePnd6WNtf+a?=
 =?us-ascii?Q?Glb9VSMcBIDEG3aa0l7daPTbjDnvo+zaWnUoJtXDNDpkhjQjes/LX8FtTJIr?=
 =?us-ascii?Q?sZgK8khGMBK35y80bukUotxp1T9fWl7r+qvCwJwiUm/U9Jkv5NTU3EZS8Sbb?=
 =?us-ascii?Q?1Ya9UgkDYjAuShCp3wfjelTFHEMhlpv1I63eEpWie1YceUxDAwfQAVBRXJ+H?=
 =?us-ascii?Q?16DQPpR4uJBMJmTElM+p1+QSiNe/SILp5rWPXG/x/qJFC0wbfdi8TOvFQYW6?=
 =?us-ascii?Q?9UnOg7MQSo2aJRYT7SqWnbLhmXqUo+kB88lleliwpcQes8V/BnN6zcyNnXhm?=
 =?us-ascii?Q?o2vv1cKaJpSRWzSpyfgr9BWY5NOhoCWaxcCOX9JxnM+sW1I2fff5//4QY+WM?=
 =?us-ascii?Q?I3jgnlmtuVYVWv26HJXB6O96z+t7HNMYvmZD/OANOBvEhM+O8ljOfzhU2/cq?=
 =?us-ascii?Q?zUXKuU/N2ULNiEIsAY3IKwY1G3RUuP6k9O4IVGi9RrR1DjpgWa+SzOzOztRo?=
 =?us-ascii?Q?pFhRSw2b4uJtZ3Ra4LGmH8UFeVVTVa7xXuwwvZ1XPQzxxNbPzAU8yH4jZIEt?=
 =?us-ascii?Q?knI7Np/Tf3FBf2Qi6WK3PafehRYJ6Qnw8fktNOUvICzkxweSqd+1ZCZKKzUu?=
 =?us-ascii?Q?H1wnF1yd+kNNEIwa6Y21hv6s4QK+WCFJEKY1+Q0TObIYlgzWyMg5RZkYEBxp?=
 =?us-ascii?Q?8QFjoUuq7HmhmT6BmaDFtUS/79bp/DrcWUU96l054GsUatniZMwUBx9m12Bv?=
 =?us-ascii?Q?z9VbCNN/XiDh6hnTFrIgM9qqVw7+PjBtoTzKxnZvByDNR19GgKIMUKhmlO6S?=
 =?us-ascii?Q?O0BNS2NzbVSiVqCiASvkRDdeKvDFGxRL14mk3YhxuSCt0wIbXpF0yJPBhszS?=
 =?us-ascii?Q?Zi/lZUGOr0xMvEPb9oUpy6UWiyfp85x21wjCzzqDYDp1Ho+F5bvjgsmEARFd?=
 =?us-ascii?Q?RNlwQgl3CQdPm6u0Fp59vFkjZ9Zw0MhFXZbTZELQOB69X0sa6uX2y8/REqDA?=
 =?us-ascii?Q?g0y83O0BlePmoqMHVKqjHoIUBAeWfRd3nsq2hfA1MZR/+h5OZLyczzAYf7vf?=
 =?us-ascii?Q?kpNKLLvC7kEgNMjVdMY8mFdOyTZG5/CtDRjbv7Tfd+2Yk0Jn4eB3zdWMwKII?=
 =?us-ascii?Q?fneFjmuTki+cgjEliIIFoYawJj/afSXQE4BX3ippCq5iSMgKI8V/d+i2AkAO?=
 =?us-ascii?Q?HjwBnDhgSdestYh8WBQv5jmCWPKfRkocwYtkW8eCF3ljXq4m7raOk2QgLjX3?=
 =?us-ascii?Q?w34MxynVz1DCbKKgM+dB40OVi8A2qpkYsZTbX6LmySquBtsR/ZrqvP7fyHR2?=
 =?us-ascii?Q?ZzfseYP9nO60cQl3BASEvNnRZCVLIJ7rH78m4e5M2oDoKlWRRKYSiAA0W+Ck?=
 =?us-ascii?Q?jqhvUcaQfao8YidGZ3S0kGKRURiw2i1Tv4JbHTnMuPVLZIhRX+HFM6Ibk5gQ?=
 =?us-ascii?Q?HFu99Bp016XpFTQ4uHzN9DK44KN67Qwx5/PGpffI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a40e28-6755-4996-6a1c-08db41761e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 08:06:17.6169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: baq+Czk/HKQxHv6FEuG1YJ1I5Sn0LzpuDLY53Cf+rRjJ1VFgvNiiX+q/pX07k+FOtwegTg0HgJOwtSKWxbn3Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6300
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 12, 2023 9:52 PM
>=20
> @@ -1858,7 +1843,15 @@ int bus_iommu_probe(struct bus_type *bus)
>  			return ret;
>  		}
>  		mutex_unlock(&group->mutex);
> -		__iommu_group_dma_finalize(group);
> +
> +		/*
> +		 * Mis-locked because the ops->probe_finalize() call-back of

I guess this comment is trying to explain why the following code is
executed out of lock. In that case it reads clearer to me to start
with "Avoid mis-lock ..." and put it before mutex_unlock().

> +		 * some IOMMU drivers calls arm_iommu_attach_device()
> which
> +		 * in-turn might call back into IOMMU core code, where it
> tries
> +		 * to take group->mutex, resulting in a deadlock.
> +		 */
> +		for_each_group_device(group, gdev)
> +			iommu_group_do_probe_finalize(gdev->dev);
>  	}
>=20
>  	return 0;
> @@ -2999,8 +2992,12 @@ static ssize_t iommu_group_store_type(struct
> iommu_group *group,
>  	mutex_unlock(&group->mutex);
>=20
>  	/* Make sure dma_ops is appropriatley set */

while at it, s/appropriatley/appropriately/

> -	if (!ret)
> -		__iommu_group_dma_finalize(group);
> +	if (!ret) {
> +		struct group_device *gdev;
> +
> +		for_each_group_device(group, gdev)
> +			iommu_group_do_probe_finalize(gdev->dev);
> +	}
>=20
>  	return ret ?: count;
>  }

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
