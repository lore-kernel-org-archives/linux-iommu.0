Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E577F5BAF0
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726116818; cv=none; b=A4W3EsEBdHhPbe3Ics/AfbEVnbqHurmUj9dJ67wvIDCrcnSB+FYZW6Ck9qYHRQQjGiSp0qprt/CVVk7crpcc3jcRdAo7Bz80eknvhJ3X4iwQhaZX6uUqNEv+vJNjDrF69phT6/UPQMg3R7MZy/kI7Pc7aw3utrDiKWZg+rJQzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726116818; c=relaxed/simple;
	bh=Wg67FOvAAGNoq1fGyUAFQP4iUXqQYadkkTm1bncLL5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+/yjU+Bso1uYWlyu+z75XxyA0VLoCdReYUFYmgmJNWudlvcRZ0KwPpO2Vnyh6sdiHFapc4EBR4u4JTtTfMX2sVUkcDxkTp/OLa5MieBiJJZ6sYHAqF59wsn29uaS2YLHYkN6EihGlvHrigzFhlJ/SKqY2ZrbDl9YzFxpsMdsVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HaQb9pUU; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HaQb9pUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=GfXA3mGsaNWNlym/aRMLc5TItv9Lh9SKYkKIl8Ioxvc=;
	b=HaQb9pUUm++ZB42VyOK/5H0OUtV70htULbb5M0HPLbuOpzNxdGE8syhzzJWECk
	u4I0gNbikX4Gz3J6q2bytpaxh/i+jJiygEsVE+784SWUVYp7RfMDjFdq/2hQ6jb0
	zKbngjMM0w12kfdXS4owY2KfhXX8ER2nQy2HG9+TGzG4I=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wBnT7quc+JmLGZrGw--.59345S2;
	Thu, 12 Sep 2024 12:53:03 +0800 (CST)
Date: Thu, 12 Sep 2024 12:53:02 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Should the return value of the rlookup_amd_iommu be checked?
Message-ID: <ZuJzrjovqkkw1jsm@iZbp1asjb3cy8ks0srf007Z>
References: <ZuJxQKseMZjTjqdt@iZbp1asjb3cy8ks0srf007Z>
 <dd76524b-34d4-4092-bb04-0f7bd45f7c5c@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd76524b-34d4-4092-bb04-0f7bd45f7c5c@amd.com>
X-CM-TRANSID:_____wBnT7quc+JmLGZrGw--.59345S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3LI6DUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYBRYamV4JMMxcQAAs8

On Thu, Sep 12, 2024 at 10:19:53AM +0530, Vasant Hegde wrote:
> During init driver will initialize rlookup_table. rlookup_amd_iommu will not
> return NULL. So its fine.
> 
> -Vasant

OK, thanks!

-- 
Best,
Qianqiang Liu

