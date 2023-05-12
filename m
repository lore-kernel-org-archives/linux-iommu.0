Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E523D43
	for <iommu@lists.linux.dev>; Fri, 12 May 2023 18:58:56 +0000 (UTC)
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4QHyZM4cp7z3rWB
	for <iommu@lists.linux.dev>; Fri, 12 May 2023 20:52:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fischbytes.de;
	s=key2; t=1683917579;
	bh=lKGQHVMSDCGGZWxoYWIEDFldZMXjM7h9ggdmiwcQrfc=;
	h=From:To:Subject:Date:From;
	b=WcpUyJuEoPIZOtSLj6DqP/bdhgNiEuC/smcQMhrACDNcgyu5AVL1bYzON1z/BFbpd
	 c8p3E33ExVtTuWPiYQszKrZqvXduE6IqauwQFRSu1FAooTuFQC18ZPx91CRjQbKX5L
	 6tuNoM5dGJgcpxW2bJKEa1au/YMBLnooy9NQwtK4lHRhnULmZ3ggYRHpTuLratkKvU
	 voNcVUwZb2UJnVTaEtw2DNsz9HnAgRoBmQNB0tEdybGw7k0H2TFF8gHgsZvP62Xr5s
	 t+3CshVXNJLnoBcRvXmHGT75IMbQ3kmkco/F/ZNeePuQx2I903vcPS/oXDpP8LwsJ1
	 s3JtGxXwqU1RQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4QHyZM3vqDz3rW4
	for <iommu@lists.linux.dev>; Fri, 12 May 2023 20:52:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
X-Spam-Status: No, score=-2.901 required=6.31 tests=[ALL_TRUSTED=-1,
	BAYES_00=-1.9, SPF_PASS=-0.001] autolearn=ham autolearn_force=no
Received: from mxe860.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4QHyZM0LSTz8tXH
	for <iommu@lists.linux.dev>; Fri, 12 May 2023 20:52:58 +0200 (CEST)
Received: from helios-lx.localnet (p200300cc9f24cc0073be15352864e555.dip0.t-ipconnect.de [IPv6:2003:cc:9f24:cc00:73be:1535:2864:e555])
	by mxe860.netcup.net (Postfix) with ESMTPSA id 5C2321C0034
	for <iommu@lists.linux.dev>; Fri, 12 May 2023 20:52:54 +0200 (CEST)
Authentication-Results: mxe860;
        spf=pass (sender IP is 2003:cc:9f24:cc00:73be:1535:2864:e555) smtp.mailfrom=bugtracker@fischbytes.de smtp.helo=helios-lx.localnet
Received-SPF: pass (mxe860: connection is authenticated)
From: bugtracker@fischbytes.de
To: iommu@lists.linux.dev
Subject: Relaxable RMRR kernel parameter for broken platforms
Date: Fri, 12 May 2023 20:52:53 +0200
Message-ID: <2282218.ElGaqSPkdT@helios-lx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-PPP-Message-ID: <168391757468.20510.12136189973612816253@mxe860.netcup.net>
X-Rspamd-Queue-Id: 5C2321C0034
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-5.50)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	CTE_CASE(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:3320, ipnet:2003::/19, country:DE];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_NO_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	ARC_NA(0.00)[]
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: u5HrE7wb//T8kWtD0/OF3CNnOF+8/d+5OKdS5uPUASm9VGYVYNHLMg==

Hi there,

I came here today to ask if there are any plans regarding the implementation 
of a "relaxed RMRR" kernel parameter to aid using IOMMU on broken platforms 
such as the ProLiant Series by Hewlett Packard Enterprise. To everyone not 
aware of the issue;

Certain vendors that are under the assumption that standards are for jerks and 
Intel's specifications are a loose optional guideline have implemented RMRR in 
such a way that every PCI device is marked as reserved and therefore cannot be 
passed through to a virtual machine. This issue has been very well documented 
by some people that have a lot more experience than I do at the below linked 
resource. I was hoping that the kernel devs could implement the Relaxed RMRR 
option as an optional kernel parameter to use on these bugged platforms as 
that would re-enable or rather enable a lot of broken servers for the first 
time ever to use PCIe Passthrough. I can verify the issue exists on a HPE 
DL360e Gen8 with trying to passthrough a GPU to a KVM/QEMU machine.

Link to fix: https://github.com/Aterfax/relax-intel-rmrr

Furthermore, since I am not a developer and wouldn't claim that I am competent 
enough to decide whether or not implementing this patch would present an issue 
in terms of stability or security, I was hoping that you could evaluate the 
situation. I can verify the pre-built packages for the Proxmox Linux 
environment fix the issue and behave identical in function to other systems 
that ignore RMRR completely, such as VMWare ESXi.

Thanks alot in advance, you implementing this patch would really mean a lot, 
since the hardware manufacturers just don't seem to care for fixing up this, 
erm, mess.

Skali S.


