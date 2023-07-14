Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93F020E8
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 14:14:56 +0000 (UTC)
Received: from 8bytes.org (p200300f6af03f600fd690381fa83412b.dip0.t-ipconnect.de [IPv6:2003:f6:af03:f600:fd69:381:fa83:412b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4810D28012A;
	Fri, 14 Jul 2023 16:14:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1689344095;
	bh=F/D7IwlzeRTbVVFVQRrvrHtSo5B6tCQYfdQKsjjGZxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jp3PihVqiKnlzmHVqFa9YWANdQakKslbqTfMqagAPFsJZPLtl8G315CluEVsz1IKN
	 ie9DKXxujsgeG6yc3N5EUKv4hmowrAcybCnSqVcPGXSf6f1UbKKapLpgV6UcIP/EqU
	 bH2afUqVj//RSfYXnQtMLpFW4OB5YeQRWWq7qiSO3OcoxmqSWH5fplE2XuwD4JeqIq
	 iSa9eGZFb+o6eR5kPvjU/SSOmAIQS5idSGf993PJZmeMdjPKUelStLuGttAQbN9hbD
	 0PVZeMlsu2K0v7/3/kMWl1qvEE3THgi6VcQFrwqzRM1aN2IQKU5IOfu0oIVL54+UUZ
	 wIto+NKQ9GfIA==
Date: Fri, 14 Jul 2023 16:14:54 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 00/10] Consolidate the probe_device path
Message-ID: <ZLFYXlSBZrlxFpHM@8bytes.org>
References: <0-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com>
 <ZJCmmOfR7Cl+OtOc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJCmmOfR7Cl+OtOc@nvidia.com>

On Mon, Jun 19, 2023 at 04:03:52PM -0300, Jason Gunthorpe wrote:
> Joerg? I think we are good on this one now, it has been quite for two weeks

Applied now, thanks Jason.
