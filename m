Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7726AABD;
	Tue, 24 Jun 2025 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754554; cv=none; b=pMa0yMawPlp9tTEMrE3XPQcy3wb8+xTOhRbA+IXgz0p/HoAvQsAaB3FJ+3AIFQWRldNknvk8rhZou3EHyPkVuQY4cdr7u6TE6zwXcqlqd/u9TjKp3xiyAnmSUfpIpw8+wQ6RVk0do6crylPWXSvpW0lW39qBqeoG6Do50vCyu+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754554; c=relaxed/simple;
	bh=79sCu4PyYzVHW/Z8QGotil/TpK5J5xXTNlL9Xox50k8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=oADWGhktTkNEw2ID90vusozC7NEjFrdq3J9I9dRaRgQ2fh14ryd3clQRL14oll8x1mZWe1Z6BDYMAltGNEvqPgbfE7RDh4ZJhDv3y3nMJTbZg+yDkWqIq2qWBuIrEguwQnO8dnRbbEBE9Ok4AsVb49PA0l8+gBN0tBB6BT5TjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=dyL5sGeG; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="dyL5sGeG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1750754528;
	bh=v6o/ShoJvWLhlSyxTPkbAI0fwmABW2L1+nINfU74Drk=;
	h=From:To:Cc:Subject:Date;
	b=dyL5sGeGpTzQFff0ZXcn7gm5frvC5bqhjbuv/f17ZYvhKLLDeY7Pnp8ZETmM7B0t+
	 DABu7EN5FsapnPyxMDGpVO1PpP0LOkpPS/ILMaSPgq+wXD3k6UgQfxdAK+3FfLgfsv
	 Y8fs4dOPsM+i2uTFwz4sD/SEWAhH64nCveJFtLDE=
Received: from KernelDevBox.byted.org ([115.190.40.13])
	by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
	id 8ED3EC23; Tue, 24 Jun 2025 16:35:45 +0800
X-QQ-mid: xmsmtpt1750754145t96osdqnj
Message-ID: <tencent_889D023A2A9B04DE8D592DFE961C5893C706@qq.com>
X-QQ-XMAILINFO: MKFQA+k1yb/29nquRTkIAQGt4f0wbGob7cvjvfJ8CF+sR9wKkmiBC4dNgvLeJp
	 fixeD0fmRyYLywArMVqyEdBYo7uQ8yPnXXLlbyMm4HBRjboZHX3FLGP4Bbb7VFN4RaNqY+X4GehU
	 f4QYVOorW3Bk3TABhklZlbqMXxqjYgdjIHBSF4Ze3WiBFF8Wv9Byx2YmeTcfCtdvLpQKe3UlSf2F
	 b8F/Y4uWPkjishF6MQA0NyXN9TLHNhK9Y6O4VvhufylnkiCIJLLurm4AOKaV/VM3U9HXSdZv4L4p
	 YRzqU8Okk51I6z9qMfccSJVOUHHIOh74DSiYVlqtWg/dJI/6e1LoAhejfUTvBhxk8o23H7c0Ium4
	 uqiGeop7q/29K2vxFgGHvjqwk+1mBqGS40M3erJFpy9d64szRhXiOxcMmuIfQrcjDDLqOsBllKaX
	 uG8OEpOwstYHThd+rBlObgV4oaebCyV0y9r1riLs3rMHmNghnrCbJ0duI2nm/OQZz2CSWstBA3pb
	 xTEsTFO2A5SQSi56BC8el+mhuVVlA9sNf+1d5k8SZVDqL7pp/j0z5jhxLbgl3JMOyGgPaTeNVGrB
	 xVdXzslCI7I5XDLr73rTMZnsA6beB3UkWvNGb6Y9qNCLOhblY3oplPcR5m5aAI55nmauJloK36rY
	 e55jd8RhPTGRdnbbXBkTKCGgtZCsfNJqWUzhRaa19caR5M+KRIHQwWyMWgByD11bV3cePftyoCGw
	 waNu4oaU8wfrlpic9SsIckgUYPvbGo2wyyhBA+tBpuFMX37B9qLms8GgW8faqCFHiFB9fBEZRjPz
	 0WUhwSxqMZjhBrn57Qhpko3uKfVxmeZQnQXTCqx9Kb229VWpQutaezaNyNQzZsvTvoCQJcdKMlw/
	 FT2TiyaEtrenAcNntLbl/wHU2LSPNE+rxUvbDzkJZc6ftfgeeI+C0T7NQzW2N29jPAeiG849zwcD
	 4SLSIHudFSsaNHQ43WfkJSkDgVFXddrcbmgkySGMUgX/OA/p1X6E1bivdg54fwW44odbtAetliGU
	 2NO1WuaA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Zhang Shurong <zhang_shurong@foxmail.com>
To: joro@8bytes.org
Cc: will@kernel.org,
	robin.murphy@arm.com,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] The sun50i_iommu_of_xlate() function didn't properly handle the case where of_find_device_by_node() returns NULL. This could lead to a NULL pointer dereference when accessing platform_get_drvdata(iommu_pdev) if the device node couldn't be found.
Date: Tue, 24 Jun 2025 16:35:43 +0800
X-OQ-MSGID: <20250624083543.1232205-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a WARN_ON() check to detect this condition and return -ENODEV when it
occurs. This ensures proper error handling and helps diagnose incorrect
device tree configurations at runtime.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/iommu/sun50i-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 76c9620af4bb..0f85850269ae 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -833,6 +833,9 @@ static int sun50i_iommu_of_xlate(struct device *dev,
 				 const struct of_phandle_args *args)
 {
 	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
+	if (WARN_ON(!iommu_pdev))
+		return -ENODEV;
+
 	unsigned id = args->args[0];
 
 	dev_iommu_priv_set(dev, platform_get_drvdata(iommu_pdev));
-- 
2.39.5

