Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D72B1EA91;
	Mon, 29 Jul 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242653; cv=none; b=NI6Z0m98V8qHEhfxTctRV/Z+8ifqHtPPW6CwU6sMcbJAc8KhexoWITrkodJWtmMx5JqzDUCOIAS0RM/yym0qGyWNJhCgBHCLzfsleohV45BTzFVdZVbQHY2ygw+g8d17NUuRFYPbFFx86hvbsoPIjQdULMfeyHUwXt4wka9SWYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242653; c=relaxed/simple;
	bh=rShIewyZd6avg7JKkjg564MWU/YMLcep4oE8pH0jYsc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GbxqGJnDb4WW9j2PcOMTAPdcAkfgD5ba7C3jXKGbVhncQQOtoMDaczRS2kooQJmphXVII6P26gQhDbXLd/ZM9ZHfXvbQ7BrK5v6VE707xvvn+hDXUFh75S4UhMXVltaa1dO6Yez0BrZn0+0SrKpzSXQhtxXFCvPGtNOTj5Kchso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VTaSDRxq; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VTaSDRxq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722242631; x=1722847431; i=markus.elfring@web.de;
	bh=rShIewyZd6avg7JKkjg564MWU/YMLcep4oE8pH0jYsc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VTaSDRxqKK7wsrKh/JRzSm2IOmZmxbzvTB/otk4sDf1yinhgn6xi4LP0vaQnWBhO
	 Lf8vBVHzRiads7QW3RZhU/ieGnByK4oeXzX+SNjh1NEI9E33ELwpPVfflJZHcr+zb
	 M/Z0iU1grqw2+rmGZ+TEMycGhyXXbAChTh/IqZnJv1dXhCVqBx7kznO7LHaTwMJiJ
	 v7S6uEDnLQ0KzqepQz2Mop5Cvj9w3SRP+aH77lOI/HBIpm+wZwXi3Irax7eP8WLi5
	 PC5yFL9C6DPDAbONX3BO+A8LDlLOYM4HJoq+rFVyiTCSngbM23zoF+2ucPujdGLuI
	 tOZdgVZSievcNHHMNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mhnvw-1s3g0734N6-00jR4l; Mon, 29
 Jul 2024 10:43:51 +0200
Message-ID: <7d572400-519f-474a-a664-82d142c71666@web.de>
Date: Mon, 29 Jul 2024 10:43:49 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ashish Mhetre <amhetre@nvidia.com>, iommu@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
References: <20240717100619.108250-1-amhetre@nvidia.com>
Subject: Re: [PATCH 1/2] iommu: Optimize IOMMU UnMap
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240717100619.108250-1-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CTK6q2tTm7sA/4gebZfgbj/zQpzebhTTRcVXvHZ+jsy2LRsBXkf
 hfERQdSQQCYkUtPYYC7qbF30zwEpqEuM4mQN0H7e7fKCROi/5MCXwIrHtCMVCtNNQCljLHF
 BKpcOboOjtmE46nbPRz16jWmmgh0qZNs/5sKbbwJ3jvButRDnKHQb5W041WvCBa+O0ZtiDz
 sw3wsjjl7jSVs7U2IuMYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0781h9qRdxg=;gXlPtzcIEO2AdXWwwxmoFIeTEIm
 /N7EQPStyb+TR5mEsFWlNiDuF0rRh31dnNG6D742hcy3n07Ev5fKOWZmY/XXNv3zFhuQ0wv5k
 6+t3bd39D25VjIUydP8p8Yr/94nJFkzLU5i1nUZL2o/Wy7o1iSq5mu11PfqZHG/4t3SBqYL3z
 VEyv3C8EeZhDixhMdMBp4p95v6a6HErza9RL8pnAbafdNMfoQO047pIXAcBpKhhN31WGJGS9b
 ZcesQCtdDTCPtkL8GINt2SWHqTzsDVo4D2Di2ZTteQNN8c74EyJakp60MCu8np0B37IeFwHHy
 qm7jUBH7uEPm7IsxwJKJVYeLkrMTEJBi7/abS5SMlcdiXMTcqy/XOOoBHsJ+RwG6lNGKN5f6y
 V8VDCx83uSkYO9Uy+dtLmXdgx2+avYNvl/zNqbc/rz6HPid/r2vIUTvgjFFzsM+Src9u0CS99
 XXakMJMRuc8WIhAKttchwGWRr5XwQO19/P1rLtvlq/dNNGpJ2d89UAuT2FEi+WN3/rzs+rQHx
 pnzULv15LF9IZwHU7SqGBhwQ8lxW7M2SVCmp4RNUZkzaoq+ZMht1swGbLzrIB3OySrYqUI2WL
 lvE8LrNo0l95kExjYUKcMEfBmrvdQ16oauv5aNjEV7WbHznCjIrFp/wTL+1RzBI72lt6cGjib
 eTRi+GcguZBQaGtLJuTaegGnZk0OS0MH6hKCztdI8DqgzWdrhTMyOI5E+ppD5F/HDz+betOrx
 rs+x0eVJhQjF2V/iU7RpYm7fpL5M3MVG8TJLJcZ33l6+0SMQuUZTRQ4n7w5uqfye8HrkhjO/4
 HgWY57/iaKiAPmIutR5vlNrw==

=E2=80=A6
> This patch optimizes =E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10#n94

Regards,
Markus
