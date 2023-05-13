Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31F2583
	for <iommu@lists.linux.dev>; Sat, 13 May 2023 19:05:36 +0000 (UTC)
Received: from mors-relay-8405.netcup.net (localhost [127.0.0.1])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4QJZfM71tmz6wZ9;
	Sat, 13 May 2023 20:58:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fischbytes.de;
	s=key2; t=1684004316;
	bh=5ik5T0uHnV1BGD/wjezdS6JaBpF5tqqCfNbuyJLYlZE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=THNeWYesdStOsLQmg8UvNmjXg02vv2Mwj2NPZAQPxRcIKoH6SxPybG6muXYugqyZz
	 I8Wi96q3Hh5SunRMl5TJttwnKSLIGrch7UilI4QAnc/A4bNB2donQty8D89NpVnC9j
	 XLmmoMtGb5ZvbcbOeAkx1Ghk1PDvrYCjmHhOmc8iaXL92Xt4kpVGuosUAu9Uqr28sA
	 qTR32JKsCAwjmztYfQrWI6mDdFnwnYl64QQDB2K7WOCF4PpGuJjDplFoKibuiIfSAX
	 nuws2KpQtEAxwlTctdKKgip6L4Xd7DhVc+3uANQYh5/HkAg/yZrMcZUSLm7uFfkJsL
	 c+3N36OTbz1Hw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4QJZfM6M2sz6wYl;
	Sat, 13 May 2023 20:58:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=6.31 tests=[ALL_TRUSTED=-1,
	BAYES_00=-1.9, SPF_PASS=-0.001, URIBL_BLOCKED=0.001]
	autolearn=ham autolearn_force=no
Received: from mxe860.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4QJZfM0zGVz8sYc;
	Sat, 13 May 2023 20:58:34 +0200 (CEST)
Received: from phaenon-lx.localnet (p200300cc9f24cc0002d861fffea9a221.dip0.t-ipconnect.de [IPv6:2003:cc:9f24:cc00:2d8:61ff:fea9:a221])
	by mxe860.netcup.net (Postfix) with ESMTPSA id 4E3281C062E;
	Sat, 13 May 2023 20:58:30 +0200 (CEST)
Authentication-Results: mxe860;
        spf=pass (sender IP is 2003:cc:9f24:cc00:2d8:61ff:fea9:a221) smtp.mailfrom=bugtracker@fischbytes.de smtp.helo=phaenon-lx.localnet
Received-SPF: pass (mxe860: connection is authenticated)
From: bugtracker@fischbytes.de
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
Subject: Re: Relaxable RMRR kernel parameter for broken platforms
Date: Sat, 13 May 2023 20:58:29 +0200
Message-ID: <12224372.O9o76ZdvQC@phaenon-lx>
In-Reply-To: <4ab4966b-48bd-56fc-5078-d5fdddc1613a@linux.intel.com>
References: 
 <2282218.ElGaqSPkdT@helios-lx>
 <4ab4966b-48bd-56fc-5078-d5fdddc1613a@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-PPP-Message-ID: <168400431054.6990.9006180677176198222@mxe860.netcup.net>
X-Rspamd-Queue-Id: 4E3281C062E
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-5.50)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	CTE_CASE(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:3320, ipnet:2003::/19, country:DE];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[]
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: uDM6FSZ2Q2giMNijK2QVnfQTCvZmmtpMnI03CuQejaqdgnYemI+l1g==

On Saturday, May 13, 2023 8:20:40 AM CEST you wrote:
> On 5/13/23 2:52 AM, bugtracker@fischbytes.de wrote:
> > Hi there,
> > 
> > I came here today to ask if there are any plans regarding the
> > implementation of a "relaxed RMRR" kernel parameter to aid using IOMMU on
> > broken platforms such as the ProLiant Series by Hewlett Packard
> > Enterprise. To everyone not aware of the issue;
> > 
> > Certain vendors that are under the assumption that standards are for jerks
> > and Intel's specifications are a loose optional guideline have
> > implemented RMRR in such a way that every PCI device is marked as
> > reserved and therefore cannot be passed through to a virtual machine.
> > This issue has been very well documented by some people that have a lot
> > more experience than I do at the below linked resource. I was hoping that
> > the kernel devs could implement the Relaxed RMRR option as an optional
> > kernel parameter to use on these bugged platforms as that would re-enable
> > or rather enable a lot of broken servers for the first time ever to use
> > PCIe Passthrough. I can verify the issue exists on a HPE DL360e Gen8 with
> > trying to passthrough a GPU to a KVM/QEMU machine.
> > 
> > Link to fix: https://github.com/Aterfax/relax-intel-rmrr
> > 
> > Furthermore, since I am not a developer and wouldn't claim that I am
> > competent enough to decide whether or not implementing this patch would
> > present an issue in terms of stability or security, I was hoping that you
> > could evaluate the situation. I can verify the pre-built packages for the
> > Proxmox Linux environment fix the issue and behave identical in function
> > to other systems that ignore RMRR completely, such as VMWare ESXi.
> > 
> > Thanks alot in advance, you implementing this patch would really mean a
> > lot, since the hardware manufacturers just don't seem to care for fixing
> > up this, erm, mess.
> 
> The relaxed RMRRs are used for legacy purpose, but it requires the full
> range of memory addresses are available after the OS device driver takes
> over the control of the device.
> 
> Not all RMRRs are of this type and typically the VT-d driver only allows
> those RMRRs for USB and graphic devices as relaxed ones.
> 
> Are you proposing to add a kernel parameter to allow any RMRR for an
> arbitrary device to be relaxed, or I didn't get the idea here?
> 
> Best regards,
> baolu

Correct, the idea here is that, while this observation can only be made on 
specific hardware, it more often than not occurs that devices that definitely 
shouldn't be (like e.g. GPUs attached to the physical PCIe Interface) are 
marked as reserved by offending firmware. A perfect solution would of course be 
to force the hardware vendors to push a firmware update that resolves the 
violation of Intel's specifications, but such a thing doesn't appear to have 
happened in the past and it's very unlikely that, let's say Hewlett Packard 
Enterprise, will ever release a firmware update for those thousands of broken 
servers. 

(Quoted from here: https://github.com/Aterfax/relax-intel-rmrr/blob/master/
deep-dive.md#rmrr---the-monster-in-a-closet ;

Intel anticipated the some will be tempted to misuse the feature as they 
warned in the VT-d specification: "RMRR regions are expected to be used for 
legacy usages (...). Platform designers should avoid or limit use of reserved 
memory regions".

HP (and probably others) decided to mark every freaking PCI device memory 
space as RMRR! Like that, just in case... just that their tools could 
potentially maybe monitor these devices while OS agent is not installed. But 
wait, there's more! They marked ALL devices as such, even third party ones 
physically installed in motherboard's PCI/PCIe slots!)

Hope this could clarify my inquiry a bit more. 


