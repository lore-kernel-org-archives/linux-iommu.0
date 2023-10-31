Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0B566C
	for <iommu@lists.linux.dev>; Tue, 31 Oct 2023 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id DDC0CA9165;
	Tue, 31 Oct 2023 11:32:27 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02mBOVTRwPNM; Tue, 31 Oct 2023 11:32:27 +0900 (JST)
Received: from [192.168.0.14] (KD111097181081.ppp-bb.dion.ne.jp [111.97.181.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id B85B9A921C;
	Tue, 31 Oct 2023 11:32:27 +0900 (JST)
Message-ID: <51af63c670164d1e7a3a483794fd41fb2e9a4622.camel@valinux.co.jp>
Subject: Re: [PATCH] iommufd: Fix missing update of domains_itree after
 splitting iopt_area
From: Koichiro Den <den@valinux.co.jp>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, kevin.tian@intel.com, den@valinux.co.jp
Date: Tue, 31 Oct 2023 11:32:27 +0900
In-Reply-To: <20231030145035.GG691768@ziepe.ca>
References: <20231027162941.2864615-2-den@valinux.co.jp>
	 <20231030145035.GG691768@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

> > +   if (!RB_EMPTY_NODE(&area->pages_node.rb)) {
>=20
> This isn't going to work entirely right because we never call
> RB_CLEAR_NODE.. Checking area->storage_domain would be appropriate

Right, thank you.

> I investigated for a while how come this doesn't crash already, and
it
> seems to be a bit because of how rb tree works, that the test never
> does an access, and a bit because we never call RB_CLEAR_NODE.
>=20
> Below improves things, and does make it crash without this change
>=20
> Anyhow I picked this with the change and below as well, thanks!

I overlooked the nodes initialization part and your supplementary
commit looks fine. Thank you. Before the patch, I initially thought
that any subsequent operation after splitting that involves storage
tier traversal, like adding another access, adding another domain
or just resources releasing part etc. can potentially do us harm.
But anyway after the fix, no need to worry and the test part you
added may be sufficent. Thank you.
