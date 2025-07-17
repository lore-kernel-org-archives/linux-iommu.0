Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63D1291C2C;
	Thu, 17 Jul 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752746505; cv=none; b=DQwXZPjjDaP/Oq3GJVQ4ndO2lezCM4oAMSjX+B5T4/If89e5bqzqgPltc9mLbscPk4S8GoVz8QkoHDLeOG54kTlshSvnB7Vklf08QWvB8sdjX+YX8+seVJYiNyfe6TAbd25C3axBKkB78I5Liiyr9fgyAz/G57Mq+7eFoWm5+Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752746505; c=relaxed/simple;
	bh=+j+eCxhAwMeuOk6CPW8cOQpG6iMGem0qQfDERMTYX1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkmUR886XH4LHOucX//Zyc82OZXbC29hta+GKjSGB73Ph/Q+ZYHmJtR4/ijD45a/TGmwKNmrDD4iE210U0TyzPa+DPRhezYm0gzPCOgso6SSxOpg8Z97mJhLEeUcW1McsVWXIZQfn0Xv4DV17sKvJhrmrkFl1khmW9ZMIaPkIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjBOa/6/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjBOa/6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE8FC4CEE3;
	Thu, 17 Jul 2025 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752746503;
	bh=+j+eCxhAwMeuOk6CPW8cOQpG6iMGem0qQfDERMTYX1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjBOa/6/rjeQmkuagBVYJ4w+ptSHrSktsNmbO3EWlM6vHNR9ypNVw27viG1YEVwyN
	 ZmiBr8p4kRj3Bolr+iAKuSgk1ZBbQvTeAgryria0lU8aQSff/Bpufo/XgxLJ2CFq2G
	 9hN5hyhJYjZpupuwASgw1SRTWWJbtUHRKEZ/Kp7t217UKJ0Fdzh+4gK8lxkdI04/Ur
	 xqkD9KJWEGhH+VkHYFJJrIGu3kvZ+dd9tHw0MlxVOLvpuyhDgzjW9zcgukHIzS43OV
	 ePK6HyZDLkCJdtjRb1XX0exJAx3oaiZRgg21m2c/N0kdFT6uJYPiVGVzPqcjYckyoX
	 txKEhvgxPhsrQ==
From: Will Deacon <will@kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ashish Kalra <Ashish.Kalra@amd.com>,
	=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] iommu/amd: Wrap debugfs ABI testing symbols snippets in literal code blocks
Date: Thu, 17 Jul 2025 11:01:27 +0100
Message-Id: <175274236192.231177.6963644719927204310.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717010331.8941-1-bagasdotme@gmail.com>
References: <20250717010331.8941-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 17 Jul 2025 08:03:31 +0700, Bagas Sanjaya wrote:
> Commit 39215bb3b0d929 ("iommu/amd: Add documentation for AMD IOMMU
> debugfs support") documents debugfs ABI symbols for AMD IOMMU, but
> forgets to wrap examples snippets and their output in literal code
> blocks, hence Sphinx reports indentation warnings:
> 
> Documentation/ABI/testing/debugfs-amd-iommu:31: ERROR: Unexpected indentation. [docutils]
> Documentation/ABI/testing/debugfs-amd-iommu:31: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> Documentation/ABI/testing/debugfs-amd-iommu:31: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> 
> [...]

Applied to iommu (amd/amd-vi), thanks!

[1/1] iommu/amd: Wrap debugfs ABI testing symbols snippets in literal code blocks
      https://git.kernel.org/iommu/c/9628e5c85b1e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
