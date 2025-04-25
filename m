Received: from mail.ptzai.id (mail.ptzai.id [103.126.10.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD7517BA3
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.10.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567009; cv=none; b=CodZd5E1TygCSIjGbdSqDlLnKUjmsbIykn5IvGJ0aTH/p6XhO/i0zogL+r5fEC3yeG58reBgo0P2aRq69rkgabuWqgjSoEFLFZfajKFx+x/fnO8y2KFZJjyvC2K2JA1wo0q+6IElsZXW2Tt9qWuK60ZAALMirRsFhduwRxOKndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567009; c=relaxed/simple;
	bh=b7CLhaODBxqyzsw/peYeuRlfRfivDGHbQ6K4oQXysKo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fiTFIlr/O9JnrClwACeneNXTqy4PwChz5epxIHB0zHWyDqw18Q8XPUIIwJObFD9VjITyFgOdm4qUBEkQFj0CK35l1GLynP7n547a8DhEF25h9K+h+uWyS3Lt4C0570gniKO9gPnv59UvHkx7woH6WSYL1rZ9wohIfay3xBgzu/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ptzai.id; spf=pass smtp.mailfrom=ptzai.id; dkim=pass (2048-bit key) header.d=ptzai.id header.i=@ptzai.id header.b=nOPgwF1M; arc=none smtp.client-ip=103.126.10.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ptzai.id
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ptzai.id
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ptzai.id header.i=@ptzai.id header.b="nOPgwF1M"
Received: from mail.ptzai.id (localhost.localdomain [127.0.0.1])
	by mail.ptzai.id (Postfix) with ESMTPS id 7C375106976C1
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 13:56:21 +0700 (WIB)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ptzai.id (Postfix) with ESMTP id 333E71069788B
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 13:45:15 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.ptzai.id 333E71069788B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ptzai.id;
	s=E96DBB9A-8BDD-11EC-9732-6913AA4D48C7; t=1745563516;
	bh=b7CLhaODBxqyzsw/peYeuRlfRfivDGHbQ6K4oQXysKo=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=nOPgwF1Mhk/g02xBTUAGLR8GCpeLHwbaOH6oNlshciKpHlGAFSOrcGT1cX/O1cwGW
	 n7MHq2J5W+EokhcSHMaBqpOhP5eLDNgHyoLX4VHb5cENcxzw0LhWQUu5q7CXJSleeQ
	 F1VWojjJQcr5PTHm1mfVfLKN5QCW54lZfopeD+vDxbLvMcDm/5lWeeCgMT3vZBT8Aj
	 2FOSjqQSnOg+x/Ot0Ia2G9QCIJIAcSp3Xydm3WlCjHXjemZAESBv1CxSR37f86j8Ov
	 FPvtoPeN7sZ+iQf+1HUBz6uqkTU4NBOD0Xe2PAXkXe7XMouCsGkVQGI/6DKVZhZ95K
	 IvSuTf0inEfXg==
X-Virus-Scanned: amavisd-new at ptzai.id
Received: from mail.ptzai.id ([127.0.0.1])
	by localhost (mail.ptzai.id [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gM8Wx_BLppbl for <iommu@lists.linux.dev>;
	Fri, 25 Apr 2025 13:45:15 +0700 (WIB)
Received: from a79-168-142-120.cpe.netcabo.pt (a79-168-142-120.cpe.netcabo.pt [79.168.142.120])
	by mail.ptzai.id (Postfix) with ESMTPSA id 9EBD110697865
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 13:45:13 +0700 (WIB)
Reply-To: adilkareemin@gmail.com
From: Investors Group UAE <syahrir@ptzai.id>
To: iommu@lists.linux.dev
Subject: Business and Project Funding Inquiry
Date: 25 Apr 2025 09:45:07 +0300
Message-ID: <20250425094507.B981D2EEE26FB5F1@ptzai.id>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Assalamu Alaikum iommu,

I hope you=E2=80=99re doing well. My name is Adil Kareem from Investors Gro=
up UAE. We work alongside private investors in the UAE to offer tailored fu=
nding solutions that help businesses like yours grow and thrive.

If you=E2=80=99re considering financing, I=E2=80=99d love to learn more abo=
ut your goals. Could you share:

The amount you=E2=80=99re seeking

Your preferred repayment timeline

I=E2=80=99ll then follow up with options best suited to your needs.

Looking forward to your response.

Warm regards,
Adil Kareem
Investors Group Representative
