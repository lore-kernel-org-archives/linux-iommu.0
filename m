Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88B48F83D
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398327; cv=none; b=doEp4yaGOaBa0tpyUQ1WyIlZhWOzwumXHMOvO1C2PX9uT1WXHnT80eMHjqGQXhk1IUFT6YuyxZCLGzGEEDIoCW9yxY/yk7/btjw1LNxsbZ2fZ+pqHSoNDz/N58ASoQ/H1tZ9MEo9I97x95UNpOTZzw0e6084/qwDmW5ZwTu00vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398327; c=relaxed/simple;
	bh=7j1FjvxzuKjZZZjuEe5PbaUUzNqOVbHpCzh8Twzsigk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyYwXUBylYQGWy7HffXh8iG4NmYQEn2e1dEY9i44CXQl+X5ZZT0uj6c+DlS8c5gVfIjn1VqdZQHRG98EsQ5j0QNWlDI9TKoh9VhJ0s4wwGEXegnLHu485FSC5xndvHknadc5qlhv2V25UTcdBgJMZyq8Ia5H2QW0Thv1PZN02AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFJI9NUy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFJI9NUy"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8623790f8so67495ad.0
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792398325; x=1793003125; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zdvEr7CMGHUXYm14SkrvOmvdQ1yeNQ3r2FisQDvIWDc=;
        b=EFJI9NUyogyZunHp0HFFL+fYZPDjSaO1hNg1gatpA3ZyCxalJ7Vx0rW7dqLg4KAQCd
         fnX6AaWg+7W6XEe740t6knDq1lt5cnF3dgkPG7uAn1g20bPyUIHhiCcLgxCQb+58loiu
         NQv9KE+WgpJWfsc0AlEbIILLmJsj6fqZWO07cV5XMDeqnKtAHQIqltoHy64/nSxUMSzt
         PJ/vdYZoXLFGqlqLbA6Juq3uS2ML88GEeodjRcA298cACB+sqb+ViEkjawDKmHTDoWL7
         nR55i1OGt+0UUL0cY4M4346iUgcAuIvZWXRhE3x2XEOf2Y7Ro1TBgxJCCUwhQKeDCZtj
         KTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792398325; x=1793003125;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zdvEr7CMGHUXYm14SkrvOmvdQ1yeNQ3r2FisQDvIWDc=;
        b=melJtOC+vtC3y5lbGJiwjdTXSnmxUDTHyCxFOFhk8UayYtmAerTo7c7YyQMxf4jKch
         7Q8IFYY5XUnML3UaLaquGcIjdoUI1goqHZ3/eVfMqY+SsAvO/PHGSplzRUyVcXcjC/LJ
         vLUjwF5/RZWsQNZQOqKKX9hrfFMkvUwxDPbKYoJ8HoyXi7WIg9rg3WhsipkQyRUIpcSi
         8RMPus/8PUaYVqiM0HjccXjNCwdo4fMF2kFyE7zEH1rRmSW+zHc8PBBjrCa/juMWd9wx
         lUoEWY7pvkh+JTPayl5O8E6TwY+u4M4ZZ7grvWiniehu84+YhDfXrg3Q7rLdOnTm2vG4
         4CFQ==
X-Gm-Message-State: AFq9FYJwlemukB7mpOKjbS+H9M5RZBSRXs0q71p+EFNo4FZ3gxBNNvhM
	MLKXfGX1YTalS6ZeCnJyUNqYETQ4D21SFrwpoTmDnAIxpcXJVkeJxObeTGFwA5OIRA==
X-Gm-Gg: AYBFou1wi7mZGNB4S8rcBPZh3noZKtvSQp5diqNlugczWic8DqnRF/92t8D09lijXlK
	g/d2h9XMwDq4yAIZ1vMnJtsdwEGrqA+W3/0Vuw0ha0QqAuz//tIZgaxQXWnau6qS4j4uv9sN8ho
	ssWefaChCQH2y8kvay9LcWKCfqlo+3KIABl/hwcGw1fx1qwog6klIBRN5Y3cm0Q2TAhjrWao0kt
	hBN9aCB60BZixNkWK02YZbPk7t7Fpk7CnqwOS1bGkswE5Q4vltgfT8pMWJpa8LEUpruQZ2Zhiub
	CteGu1gsf7uhdLEMmh5CkT66TLjMecMXjGwqZKlukPJbWr08EqemOdr4/7L6YeIDOR7pVFhf7OR
	CwT+UJlgTH38doJ54+AHLxjgu/9qsojkKQug9sv+j3vFiXfbpN4KMJB8cywBphw+82K3Zwm/sr6
	+NsonLq9M5832wFHBl7K89mAY+8pMJHBF5HFSgA0sAsDhJTxzdOAnyMDRC9DLCQnmeQTT93qgaV
	VoOMemsLy8a58SIRGE58NCTAsBRpCpdak9jef9MN3FxTf4JyEIvTNKrWu3VY9cWMLxeZN3HFD5S
	JIqPlJhvTch8P4MxN3DLZZjzzBo/T6WgUAX6ya0=
X-Received: by 2002:a17:902:d506:b0:2e9:492d:f1a0 with SMTP id d9443c01a7336-2e9b332b549mr6191375ad.16.1792398324879;
        Mon, 19 Oct 2026 01:25:24 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94794dd9sm19384883a91.12.2026.10.19.01.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:25:24 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:25:16 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <atXT7FtKrA2e1f8Q@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <asZSQRSYBjbUaaH0@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asZSQRSYBjbUaaH0@willie-the-truck>

On Wed, Oct 07, 2026 at 03:08:01PM +0100, Will Deacon wrote:
> On Tue, Sep 29, 2026 at 03:45:05AM +0000, Pranjal Shrivastava wrote:
> > Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
> > queue's producer index to safely gate command submissions during device
> > suspension.
> > 
> > The flag embeds the suspend state directly into the existing global state
> > The flag is checked in the cmpxchg loop in arm_smmu_cmdq_issue_cmdlist(),
> > which acts as a Point of Commitment, ensuring that no indices are
> > reserved or committed once the SMMU begins suspending.
> 
> I'm not familiar with the term "Point of Commitment". Is that something
> you came up with? Without a general definition, I think I'd prefer to
> avoid using it, especially as it sounds like something to do with the
> Arm memory system (where we already have architectural terms such as
> "Point of Coherency".
>  

Ack. I'll re-word this to avoid confusion.

Thanks,
Praan
