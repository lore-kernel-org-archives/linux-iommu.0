Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4630537E7;
	Fri, 29 Mar 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711707974; cv=none; b=tYds0zqQR/vebHAG8CGG2AlYftbt5UmyB2R8XAzfTlrJq2FeuJ9dCN/zPy+ByIj5J2Xl+Pk7ChOaMOTvssDvCZvwIRSrIRoqv1dgzGvCi9AFVqHw2zNQ+7+eua97aot42o0g/qAGnHFlGlxzT9tpyvXbTJhc3JQabi2aHQeZhIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711707974; c=relaxed/simple;
	bh=5HsVf48UHsg+NTDSqDhYQQl26cb9eFPNa7OAZUKIG1w=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ib5c1t8ehS3oaqgmeeyMDjUXl+SEQH3AOGKetVIEoia7b0WnkZ1Kifxjp8iOaed+UAdVjEZQu2M9/wsNidwvAmOQfooIQDIK80HLaG6dixKH+9t6G8OYOWpGXh36D7pO/WEkz+Qto0lohxsNCR+s0XI8wsiLYi5bVRWb65Sg8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rwqXmmHV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rwqXmmHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0536C433F1;
	Fri, 29 Mar 2024 10:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711707974;
	bh=5HsVf48UHsg+NTDSqDhYQQl26cb9eFPNa7OAZUKIG1w=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=rwqXmmHVsiZitHC4bhLxvsv4SFNWvAwFeLvbOIu32FbKEU7svZM8ryaoEJuTEWigp
	 C9bYITr4oQieba6IaiO1HfDehTDzM0G5b1hzPSTfTSO4x1a1iiduJdE7nsPnAWKVsO
	 OuLC3Jr7OQC2TubbSG18uugMuLyahytYCHgtaQPo=
Subject: Patch "iommu: Avoid races around default domain allocations" has been added to the 6.1-stable tree
To: 0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com,0-v8-81230027b2fa+9d-iommu_all_defdom_jgg@nvidia.com,gregkh@linuxfoundation.org,iommu@lists.linux.dev,joro@8bytes.org,quic_charante@quicinc.com,quic_nprakash@quicinc.com,robin.murphy@arm.com,will@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 29 Mar 2024 11:26:05 +0100
In-Reply-To: <cbf1295589bd90083ad6f75a7fbced01f327c047.1708680521.git.quic_nprakash@quicinc.com>
Message-ID: <2024032904-unkempt-stride-6127@gregkh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    iommu: Avoid races around default domain allocations

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     iommu-avoid-races-around-default-domain-allocations.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From quic_nprakash@quicinc.com  Fri Mar 29 11:20:13 2024
From: Nikhil V <quic_nprakash@quicinc.com>
Date: Mon, 4 Mar 2024 16:40:50 +0530
Subject: iommu: Avoid races around default domain allocations
To: 
Cc: Charan Teja Kalla <quic_charante@quicinc.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, Nikhil V <quic_nprakash@quicinc.com>, <stable@vger.kernel.org>
Message-ID: <cbf1295589bd90083ad6f75a7fbced01f327c047.1708680521.git.quic_nprakash@quicinc.com>

From: Charan Teja Kalla <quic_charante@quicinc.com>

This fix is applicable for LTS kernel, 6.1.y. In latest kernels, this race
issue is fixed by the patch series [1] and [2]. The right thing to do here
would have been propagating these changes from latest kernel to the stable
branch, 6.1.y. However, these changes seems too intrusive to be picked for
stable branches. Hence, the fix proposed can be taken as an alternative
instead of backporting the patch series.
[1] https://lore.kernel.org/all/0-v8-81230027b2fa+9d-iommu_all_defdom_jgg@nvidia.com/
[2] https://lore.kernel.org/all/0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com/

Issue:
A race condition is observed when arm_smmu_device_probe and
modprobe of client devices happens in parallel. This results
in the allocation of a new default domain for the iommu group
even though it was previously allocated and the respective iova
domain(iovad) was initialized. However, for this newly allocated
default domain, iovad will not be initialized. As a result, for
devices requesting dma allocations, this uninitialized iovad will
be used, thereby causing NULL pointer dereference issue.

Flow:
- During arm_smmu_device_probe, bus_iommu_probe() will be called
as part of iommu_device_register(). This results in the device probe,
__iommu_probe_device().

- When the modprobe of the client device happens in parallel, it
sets up the DMA configuration for the device using of_dma_configure_id(),
which inturn calls iommu_probe_device(). Later, default domain is
allocated and attached using iommu_alloc_default_domain() and
__iommu_attach_device() respectively. It then ends up initializing a
mapping domain(IOVA domain) and rcaches for the device via
arch_setup_dma_ops()->iommu_setup_dma_ops().

- Now, in the bus_iommu_probe() path, it again tries to allocate
a default domain via probe_alloc_default_domain(). This results in
allocating a new default domain(along with IOVA domain) via
__iommu_domain_alloc(). However, this newly allocated IOVA domain
will not be initialized.

- Now, when the same client device tries dma allocations via
iommu_dma_alloc(), it ends up accessing the rcaches of the newly
allocated IOVA domain, which is not initialized. This results
into NULL pointer dereferencing.

Fix this issue by adding a check in probe_alloc_default_domain()
to see if the iommu_group already has a default domain allocated
and initialized.

Cc: <stable@vger.kernel.org> # see patch description, fix applicable only for 6.1.y
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
Co-developed-by: Nikhil V <quic_nprakash@quicinc.com>
Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/iommu.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1741,6 +1741,9 @@ static void probe_alloc_default_domain(s
 {
 	struct __group_domain_type gtype;
 
+	if (group->default_domain)
+		return;
+
 	memset(&gtype, 0, sizeof(gtype));
 
 	/* Ask for default domain requirements of all devices in the group */


Patches currently in stable-queue which might be from quic_nprakash@quicinc.com are

queue-6.1/iommu-avoid-races-around-default-domain-allocations.patch
