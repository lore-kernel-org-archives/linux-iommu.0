Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B823A2E7F39;
	Thu,  9 Apr 2026 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743750; cv=none; b=WpWnjzHhnudQRf2GCWLw+LCPA+WAMShkaRjax1Ry9VaL3vfQj2BfQ7Bbwz6ItUARTYyL3KSWESoDp1qQkDQSbs8nHrFjYEvo5LT0JcOfz6g9rNLDJfHah/C0l+usSJT39tL+SpHKZG8Yz/0zcVV2OOx4ud4zs3Wsw7DI/GsPU6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743750; c=relaxed/simple;
	bh=solfwnQ+j/IyIEvEzwK5SXldPVKSwmu/ZqozUA8j+os=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pywwC7OXfl4s/HCI6eRvQIYGXmiAR3Rbn3/DlT0bEcyfHkVNUTRsm6CC9RF9P3DREnqxEdAUizWD5s00LCxpBj9S0OAdfPaLBFjXXryPguE6SvIAB/QZvbw49zMtG+cvpyjC3w7xgpzdQQaJ6qZ5e9VIHYcB0o+8tzzUvYtYLLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsfNn4ja; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsfNn4ja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A048DC19424;
	Thu,  9 Apr 2026 14:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775743750;
	bh=solfwnQ+j/IyIEvEzwK5SXldPVKSwmu/ZqozUA8j+os=;
	h=Date:From:To:Cc:Subject:From;
	b=QsfNn4jaVlZALnblWyqHfmGaxawDV8L39rq3psY5X7uKEHBNeTsWOzS5w+kWO4sys
	 +1c/JigwTBZY/DWWYGJVJUVNoAy/m+assucaD2hwe1tLUNiVaAEuj4/3TNMqpq9cuz
	 UZPSSuXK3gdJYsVdm3eIwvja3YjK4XGBf7rBeIIEI6pO3Wm5FQd/YlgGBwBOj8Secr
	 Iud4HwU92IiwlqUsp8ZxV2pKt/AslP9XGCzFmcVxKoHXvcr8xINFPynVrL54tMT4cg
	 m1fEUublwMH2zAMB7ndcswzNtM5o8szdCBeFwwtiDE6jrAaXA/dH2xfTbcgKZr++Q7
	 zbFzSMJLm+qaw==
Date: Thu, 9 Apr 2026 15:09:03 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	robin.murphy@arm.com, jgg@nvidia.com
Subject: [GIT PULL] IOMMU Fix for Linux v7.0
Message-ID: <adey_8n4Ux1qhZrL@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Joerg is on hols this week, so I'm helping out with the IOMMU tree. I
wasn't expecting anything at this stage of the release cycle but, sadly,
one of the fixes for -rc7 introduced a regression of its own.

Thankfully, Robin and Jason were on top of it and Russell and Jon both
confirmed that it fixes the horrible issues they were seeing.

Summary in the tag, please pull.

Will

--->8

The following changes since commit 8b72aa5704c77380742346d4ac755b074b7f9eaa:

  iommupt/amdv1: mark amdv1pt_install_leaf_entry as __always_inline (2026-03-27 09:41:48 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.0-rc7

for you to fetch changes up to 7e0548525abd2bff9694e016b6a469ccd2d5a053:

  iommu: Ensure .iotlb_sync is called correctly (2026-04-09 13:07:13 +0100)

----------------------------------------------------------------
IOMMU Fix for Linux v7.0-rc7

- Fix regression introduced by the empty MMU gather fix in -rc7, where
  the ->iotlb_sync() callback can be elided incorrectly, resulting in
  boot failures (hangs), crashes and potential memory corruption.

----------------------------------------------------------------
Robin Murphy (1):
      iommu: Ensure .iotlb_sync is called correctly

 drivers/iommu/iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)
