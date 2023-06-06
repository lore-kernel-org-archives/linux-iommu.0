Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9327125B1
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:58:55 +0000 (UTC)
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4Qb9XB5v1fzZFR2B;
	Tue,  6 Jun 2023 20:58:50 +0800 (CST)
Received: from a007.hihonor.com (10.68.22.31) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Tue, 6 Jun
 2023 20:58:53 +0800
Received: from a007.hihonor.com (10.68.22.31) by a007.hihonor.com
 (10.68.22.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Tue, 6 Jun
 2023 20:58:52 +0800
Received: from a007.hihonor.com ([fe80::fc39:c25:3c0f:a4e7]) by
 a007.hihonor.com ([fe80::fc39:c25:3c0f:a4e7%10]) with mapi id 15.02.1118.021;
 Tue, 6 Jun 2023 20:58:52 +0800
From: gaoxu <gaoxu2@hihonor.com>
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>,
	yipengxiang <yipengxiang@hihonor.com>, "wangbintian(BintianWang)"
	<bintian.wang@hihonor.com>
Subject: =?gb2312?B?s7e72DogW1JFU0VORCAgUEFUQ0hdIGRtYS1yZW1hcDogVXNlIGt2bWFsbG9j?=
 =?gb2312?Q?=5Farray/kvfree_for_larger_dma_memory_remap?=
Thread-Topic: [RESEND  PATCH] dma-remap: Use kvmalloc_array/kvfree for larger
 dma memory remap
Thread-Index: AQHZmHakTjKG3Wk/TNCzbQyr42cDew==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Tue, 6 Jun 2023 12:58:52 +0000
Message-ID: <8503f60f264342018384b5427ac361e4@hihonor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.164.11.140]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Z2FveHUgvauzt7vY08q8/qGwW1JFU0VORCAgUEFUQ0hdIGRtYS1yZW1hcDogVXNlIGt2bWFsbG9j
X2FycmF5L2t2ZnJlZSBmb3IgbGFyZ2VyIGRtYSBtZW1vcnkgcmVtYXChsaGj
