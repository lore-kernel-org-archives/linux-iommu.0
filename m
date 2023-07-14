Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78271134A1
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 14:21:02 +0000 (UTC)
Received: from 8bytes.org (p200300f6af03f600fd690381fa83412b.dip0.t-ipconnect.de [IPv6:2003:f6:af03:f600:fd69:381:fa83:412b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1EE5828012B;
	Fri, 14 Jul 2023 16:21:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1689344461;
	bh=DG5czGl0PdX8qjcBlP5ROLQpmgHHJcWZQapI3/0G9hQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klwFp9oGfGitZ8Pxy0KNMVOFQgQRnIPCW1zafgamKml7SMEFxfKrR9HQ67MT+UrvN
	 9CWsZ2Q9YjcJyLBKw3b+2vGmu0lTtnyso9DfE3Bfp7AMZar6hmIEXRzBGDfWubNGcl
	 bndUsKGLSvRuiua4iENmlNKUfTrFsEMq/4bjmyjssPrlHUGEOLcd/qauojyAjnUErx
	 wRfSg/6a4WEzQsPp0igT1DeK9ov+wyJXgrFG6l1tV9Fw4uKakjZxB+TWFYovnJK6nE
	 qj3s49Y7ZFyEH2b6Lj3zVU35qqPEvzRXQ17F1DkDoxxWw3KFJo4wQ7WeGcsW16aG53
	 8s9PxP4uKih7g==
Date: Fri, 14 Jul 2023 16:20:59 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	joao.m.martins@oracle.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/amd: Interrupt handling improvements
Message-ID: <ZLFZyyv2ur0VjDkK@8bytes.org>
References: <20230628053222.5962-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628053222.5962-1-vasant.hegde@amd.com>

On Wed, Jun 28, 2023 at 05:32:20AM +0000, Vasant Hegde wrote:
> Vasant Hegde (2):
>   iommu/amd: Refactor IOMMU interrupt handling logic for Event, PPR, and GA logs
>   iommu/amd: Enable separate interrupt for PPR and GA log
> 
>  drivers/iommu/amd/amd_iommu.h       |  3 +
>  drivers/iommu/amd/amd_iommu_types.h |  9 +++
>  drivers/iommu/amd/init.c            | 50 ++++++++++++----
>  drivers/iommu/amd/iommu.c           | 93 ++++++++++++++++-------------
>  4 files changed, 100 insertions(+), 55 deletions(-)

Applied, thanks.
