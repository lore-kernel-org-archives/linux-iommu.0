Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641B77E0
	for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 07:12:43 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 2550E669; Tue, 26 Jul 2022 09:12:39 +0200 (CEST)
Date: Tue, 26 Jul 2022 09:12:37 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Disable guest vapic logging during early
 kdump init
Message-ID: <Yt+T5ZcvhGaK1e/h@8bytes.org>
References: <20220721003439.403435-1-jsnitsel@redhat.com>
 <Ytq2GRX7UJjvXk4w@8bytes.org>
 <a07eded4-c1d7-edf5-9c0e-dfa0c3373e4c@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07eded4-c1d7-edf5-9c0e-dfa0c3373e4c@amd.com>

Hi Suravee,

On Mon, Jul 25, 2022 at 02:05:59PM +0700, Suravee Suthikulpanit wrote:
> Sorry for late reply. I have been actually working on the new GAM and GALOG enabling code,
> which should also address this issue as well. I'll send out the patch soon.

Okay, how about basing your changes on Jerry's fix? A backportable fix
for a real issue is always better than a bigger rework (which can still
happen on-top).

Regards,

	Joerg
