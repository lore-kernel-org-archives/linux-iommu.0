Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9985210EF
	for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 14:57:28 +0000 (UTC)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id ECF731A203A;
	Tue, 26 Sep 2023 16:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1695740247;
	bh=8NKKIqZu7KIaGrjCk0JfQDvcnQ1z/UDTf6T+J4nlMus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hv0TUg5198ANHjRFj/KoyC3CnL5ix4ZJsArXSU6BzNqixpvi28ImEPN6ZjkwEI6SG
	 SOeRBCozaEyorpMpwmD1Z39vMedHfayXI+6n4PTdhfj7KnkTeAGS+qwtkhrPRzj4v/
	 +0oL3vg6zhg0LRHyNsleRDJpU2qKqLNggLYnCJqPMMKqu3lAEzN61E+efxXk+MNvlB
	 hhXfce3dWCmJeO+AuNfE+vprkv2CWUU0KAjb9++47t5m49aHwjXGq7CsHEXvKWqoPd
	 zdkQbQkjmucPyV2j0uZlQo/BdLixeDdmtnWb7yOFSjYzo8oLJJmUqRbHkzkVNFEBsp
	 TS9HZzcH1ZR2A==
Date: Tue, 26 Sep 2023 16:57:25 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
	will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
	heiko@sntech.de, thierry.reding@gmail.com, vdumpa@nvidia.com
Subject: Re: [PATCH 0/8] iommu: Clean up map/unmap ops
Message-ID: <ZRLxVQb1zUqKTJNd@8bytes.org>
References: <cover.1694525662.git.robin.murphy@arm.com>
 <ZRFbbyxB0AwC-V_5@8bytes.org>
 <2360630.NG923GbCHz@jernej-laptop>
 <ZRKjI12cdRikwlTu@8bytes.org>
 <d88b244f-75b2-6b22-109e-7429b4c8d77c@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d88b244f-75b2-6b22-109e-7429b4c8d77c@arm.com>

On Tue, Sep 26, 2023 at 01:01:28PM +0100, Robin Murphy wrote:
> No functional issue, and TBH I think there's no harm in avoiding the
> dependency (I was kind of assuming you would pick this series to the core
> branch, so the "placeholder" status might extend that far too) - it should
> just mean that when you pick Jernej's patch to a topic branch you'll get a
> conflict merging it to core, and the correct resolution will be to take
> everything from that branch and replace my patch.

Alright, thanks for clarifying. I hereby ask Jernej to base his new
patch on the core branch, once I published it (which should be later
today).

Regards,

	Joerg
