Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB867A47
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 04:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726116190; cv=none; b=EaiY6TAlzt34Y8lUXd0TRvt5GSWwyMyryBGTF4p3cSSbQZdgPW9Pg2CRSb9TTlejnsPBwzG6yvFGEYxpIrcHJopTBfdpCEiPwEnm0J4YWzUmW72GDw/jnT9hvt5/HBG35ncSO10ZFtLYJYWsecTiLs/Tw3PmR8KJ8XXA2HwIC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726116190; c=relaxed/simple;
	bh=6Ydd8hYQ1veO1ghv2CSyamJtHmIaLU6XmKYs6l1JDiE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DzVNuxyH9goC8xdXzaJvRbLPMEXMQpWBvcyDqjqgkOQJROCjbCCztxyn5LL0Fz9RYz5UYwaYCD3MMgoVumphm1a7zg1CmRhxmzsVbRKcF1sHan2ZkqwMN+NoaV2ZtvyQfGAkrPMI+cOJtGBDQVXLCYiDXIFpkoFxOEBB7YZ9MbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S4xAefH2; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S4xAefH2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Y7fdCnqs5b3VnAoZWKrjPkiMNl58Ftcb2DcpAcXLHeg=;
	b=S4xAefH2NIYAnnWpjrb0LnyqxL1lWGgoZWhkdXVOP2w5DynW7pvJLKkddWGJFK
	Jqt3oo+vv9GikwnTQmTDetqwTUK3aDEmukjkcCxSXfUsyYYW92wp57EnDhtACk44
	K1YCihvAWUnx6oFImuZVA0okHLYD5ETBYvBFC3tO8dSCg=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wCHLfhAceJmmrkbAA--.2293S2;
	Thu, 12 Sep 2024 12:42:41 +0800 (CST)
Date: Thu, 12 Sep 2024 12:42:40 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: suravee.suthikulpanit@amd.com, will@kernel.org
Cc: vasant.hegde@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Should the return value of the rlookup_amd_iommu be checked?
Message-ID: <ZuJxQKseMZjTjqdt@iZbp1asjb3cy8ks0srf007Z>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID:_____wCHLfhAceJmmrkbAA--.2293S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw17JF1kGr4UXrW7XFyUAwb_yoWfGFX_ur
	ySvFy8Ww4rAw4UArWjqFn3Xr95Gw18ZFZY934rKF95Gw1Sqa1UuFWDXr42vrZ7GwnrJFn5
	Jrn5J3ZxGF9xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUepMKtUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLwVYamVOGR9W6QAAsK

Hi,

I reviewed the following code:

1592 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
1593 {
1594 	struct iommu_dev_data *dev_data;
1595 
1596 	list_for_each_entry(dev_data, &domain->dev_list, list) {
1597 		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev); <-
1598 
1599 		set_dte_entry(iommu, dev_data); <-
1600 		clone_aliases(iommu, dev_data->dev);
1601 	}
1602 
1603 	list_for_each_entry(dev_data, &domain->dev_list, list)
1604 		device_flush_dte(dev_data);
1605 
1606 	domain_flush_complete(domain);
1607 }

The "rlookup_amd_iommu" function may return NULL, and the "set_dte_entry" function
will call "get_dev_table" which will dereference the NULL pointer.

Is this an issue that may cause panic? Or will "rlookup_amd_iommu" function never
return NULL?

-- 
Best,
Qianqiang Liu

