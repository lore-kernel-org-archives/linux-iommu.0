Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DAE15B122;
	Wed, 28 Aug 2024 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840866; cv=none; b=L+/hGnkzk27AOzYd1V3YIwToHcBc+K8S0P2MkXm0z/Cc/82Fk3GVP6XKAJdzS/Qh1OYst+NJFiDWuHrfQuyr1wNHveRmMeiENfbx7m7CYHiN2EA1814IkTxcyfeRg2UQrvsK2GSN8GZ6wIMIOsVXL473uB8RFzbouXadnwhYDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840866; c=relaxed/simple;
	bh=InwyAHiphiLoauN/TOlOZopB6HciWGjJ5V3qgG694Z4=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=X8wpfl7NUukqIlEX0QdST7ykQiJTrCKFD9yFLxU5ZA25nyp0xH7TrM19yFpCemL/V847VUueY/1387UgzW9SM5xYtGcqtIZzYW4aA0apywT3F9GtRdPASu1CFkOcD/DNgARkRl8V20MElp7KODEEtteSRAf30Q/n4gtTpmCKfWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=vc5BhOSg; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="vc5BhOSg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Reply-To:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=NhvfR4j9bveSdtIcTWCvoQaitcmCKHIR8EyUnxLaags=; t=1724840864;
	x=1725272864; b=vc5BhOSgHL1zB/Y4MCSUbq4V5MJVRoqWyBdq8pg026A/qVfgL+8CWa28aOCsf
	Atpzy3yh3NsIjZ79OT+zPvga25l4XHg4L26ySObgTtIpNXcIwIHbtok1+f/DgdhxUaaVwh/TnwTIi
	LQq6A07QayGBuFYLcI/S3BWzUX6NdwP7ad/pnwys8RbP99pTb9YAgQfQ4cT/cGR/t34tZoyhOKSjn
	+z1ODhMsCMArRW67JPpWlNMLVnXu1GyGrnyjhR+Dsdz+CVYeOPV43CKMJOzGSxESfwKOgiShLPNVO
	tz0vRCPBr1Gq1Qoi7U3NliFTR6/2//ZFkTgo+fi/dq5yIKM6nA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sjFtk-0005PF-13; Wed, 28 Aug 2024 12:27:32 +0200
Message-ID: <c844faa0-343a-46f4-a54f-0fd65f4d4679@leemhuis.info>
Date: Wed, 28 Aug 2024 12:27:30 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Adam Williamson <awilliam@redhat.com>, Markus Rathgeb <maggu2810@gmail.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] usb and thunderbould are misbehaving or broken due to
 iommu/vt-d change
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1724840864;ad37042d;
X-HE-SMSGID: 1sjFtk-0005PF-13

Hi, Thorsten here, the Linux kernel's regression tracker.

Lu Baolu, I noticed a report about a regression in bugzilla.kernel.org
that appears to be caused by a change of yours:

2b989ab9bc89b2 ("iommu/vt-d: Add helper to allocate paging domain")
[v6.11-rc1]

As many (most?) kernel developers don't keep an eye on the bug tracker,
I decided to forward it with this mail. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=219198 :

> USB is working on my Dell WD19TB Thunderbolt Dock with Fedora kernel build 6.10.0-64.fc41.x86_64
> 
> It does not work with 6.11.0-0.rc4.38.fc41.x86_64 anymore.

The user later bisected the problem with a vanilla kernel to the commit
of yours. There are various error messages in comments to that ticket.
Some of them:

> Aug 27 11:51:07 b0v9by3 kernel: DMAR: DRHD: handling fault status reg 2
> Aug 27 11:51:07 b0v9by3 kernel: DMAR: [DMA Read NO_PASID] Request device [04:00.0] fault addr 0xffffe000 [fault reason 0x0c] non-zero reserved fields in PTE
and

> Aug 26 10:33:49 foobar kernel: xhci_hcd 0000:04:00.0: Abort failed to stop command ring: -110
> Aug 26 10:33:49 foobar kernel: xhci_hcd 0000:04:00.0: xHCI host controller not responding, assume dead
> Aug 26 10:33:49 foobar kernel: xhci_hcd 0000:04:00.0: HC died; cleaning up
> Aug 26 10:33:49 foobar kernel: xhci_hcd 0000:04:00.0: Error while assigning device slot ID: Command Aborted
> Aug 26 10:33:49 foobar kernel: xhci_hcd 0000:04:00.0: Max number of devices this xHCI host supports is 64.
> Aug 26 10:33:49 foobar kernel: usb usb5-port2: couldn't allocate usb_device
> Aug 26 10:33:49 foobar kernel: usb usb6-port2: couldn't allocate usb_device
> Aug 26 10:33:57 foobar kernel: usb usb2-port1: unable to enumerate USB device

See the ticket for way more details.

The initial report is from Markus Rathgeb, who is CCed. Adam Williamson
(also CCed) deal with similar symptoms on another machine. Both are from
Dell. In both cases Thunderbolt is involved, too.

There is also another report with somewhat similar errors messages, also
from a Dell machine:
https://lore.kernel.org/all/3b42a3cc-2f76-4d42-abe2-5f4e8ffe10e4@molgen.mpg.de/

Not sure if that's the the same problem, hence did not CC that reporter.
Will send a heads-up to that thread and point to this thread and the ticket.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1]

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: f90584f4beb84211c
#regzbot title: iommu/vt-d: usb and thunderbould are misbehaving/broken
#regzbot from: Markus Rathgeb <maggu2810@gmail.com>
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219198
#regzbot ignore-activity
