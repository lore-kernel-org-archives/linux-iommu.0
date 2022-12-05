Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016647C
	for <iommu@lists.linux.dev>; Mon,  5 Dec 2022 12:44:53 +0000 (UTC)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9F7CC220316;
	Mon,  5 Dec 2022 13:44:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1670244292;
	bh=BmZ14JxHStKwWdRniMvVcCaFX2OlpCCH2cMImuhjvdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hif7a7SKkMOGlyNeqaNPniSMimGjvQbhsAWDy+rUi2qg9pvln30Q2NBduCYQ4zPFL
	 LANZjo9U/Pn6qfunWQCzNmhjZO4mcK1lUMwF8GDE59jkTV2VODDfZymnCYGdgdH0Q0
	 W21+wnzUxNEzdPAXw7hhrWQ4FnixvLbyibHAFOxeJQ1h8rJ62hBI9aYO+R0kJNkRIB
	 mcRcfJmq3FoB5ijx0ABnULN5UwPeqa6/O147tXRPQt0bbZDzzllxfS4t0NEO9s3GAX
	 DomDehszgf0QC4mnmJF7TfYFrhGV5QpIBLnUyMff6z/O2D13Xg3uECBQf7+BdouK4q
	 HrXuC19AssvHA==
Date: Mon, 5 Dec 2022 13:44:51 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Yuzhang Luo <yuzhang.luo@intel.com>
Subject: Re: [PATCH v3] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
Message-ID: <Y43nw0vZLfy9aFUz@8bytes.org>
References: <20221130062449.1360063-1-jacob.jun.pan@linux.intel.com>
 <Y43LUVS1heMxGBC7@8bytes.org>
 <b64c5b16-79bd-182d-354b-73a74430a8cc@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64c5b16-79bd-182d-354b-73a74430a8cc@linux.intel.com>

Baolu,

On Mon, Dec 05, 2022 at 06:59:19PM +0800, Baolu Lu wrote:
> Is this still feasible?

Can you please review the fix and provide your tag? I will put in the
fixes branch then.

Regards,

	Joerg
