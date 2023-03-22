Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098CBA44
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 22:24:12 +0000 (UTC)
Date: Wed, 22 Mar 2023 17:17:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1679523477; bh=1XSQgR6v3e90rBs5bY14hmQ5qe+38CfYiwDX/0EaKO0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=USHkYZAud3KB8uMQTgbwm10E5BipfZ3q7JnCDhziDI1YfTYm7nCQElsvLOqFlPClE
	 dQY0yLPYGPTPAUTvIJBzspqut2cJvQQktrBQF+Jr2aPQ9CTWJl6sEmKK1ozafdnnln
	 mPs7A48sY1SuxsiyiXRqAOdAvbqrMQatfWwgfHaU=
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Message-ID: <038c1035-20fd-4054-984d-524c9a7f390d@t-8ch.de>
In-Reply-To: <ZBsAjPxV8bu7jjEd@8bytes.org>
References: <20230214-kobj_type-iommu-v1-1-e7392834b9d0@weissschuh.net> <ZBsAjPxV8bu7jjEd@8bytes.org>
Subject: Re: [PATCH] iommu: make kobj_type structure constant
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <038c1035-20fd-4054-984d-524c9a7f390d@t-8ch.de>

Hi Joerg,


Mar 22, 2023 08:20:14 Joerg Roedel <joro@8bytes.org>:

> On Tue, Feb 14, 2023 at 03:25:53AM +0000, Thomas Wei=C3=9Fschuh wrote:
>> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
>> the driver core allows the usage of const struct kobj_type.
>>
>> Take advantage of this to constify the structure definition to prevent
>> modification at runtime.
>>
>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>> ---
>
> Applied, thanks.

Thanks!

> Btw, b4 reported DKIM errors checking your patch submission. Can you
> check the DKIM setup on you email domain, please?

Should be fixed for some time.
(After this patch, though)

Thanks for the hint!

Thomas
