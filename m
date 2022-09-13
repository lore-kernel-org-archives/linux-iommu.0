Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE333DA
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 14:10:22 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 613B0320083A;
	Tue, 13 Sep 2022 10:10:21 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Tue, 13 Sep 2022 10:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1663078220; x=1663164620; bh=QhEV/7XGHmAwPbGnb00dXP+AbwUjSJ8L2UO
	qveXOffY=; b=p1GKDnzgV87y+ki1jEuIIceBOosrIMRJlMfVOQboYFL5sOKcndU
	+1UnNnfkvxfldLfTOSAhQeyJqeOXjN5SZeQwgOE24RZIDn4S/QdCI7FFXQxKnq5O
	ff8k7fPhaGidOb9DEPeTaCWoJoP11g684qe4zxK0++umkX+bPf1Lp8mFad28MQIw
	v8pFB9PSyUpgjA3LCE6+6JujTrV++iWToU08oJTxn6TmBtFDUrHa6hxkDOEfo9Ao
	4KlaPzVseJc6s7LB5jA+hgh+4AvuHQONVhtqIDo8TwgOMgSbzYCYWmTk5qJpliSc
	8jjWztFOxR9dGUtOqPT2pYp0uLh+zBIkU7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:mime-version
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663078220; x=
	1663164620; bh=QhEV/7XGHmAwPbGnb00dXP+AbwUjSJ8L2UOqveXOffY=; b=o
	cr613XYOWwWIo+RJkx1oGpDONRpneIQv9qgJaZLItlRkeWOWb2HCxKZI3fgryWwY
	BuSMfc0pKSsNv/k8DpQX46HK2UDoHzzN0au/pmPAJdtWWtz8CNKCIFCq6iV6EbfP
	SaQmTNp6mjP0B/t1OoxhBKpnmR4Ie3dlcfITqvGAq5GHlX4WyAkd4BtWjCrk74hA
	VT3Cv0JJNzEtMaVDDvh2OQysouOZLM+TWqXfN7yFzG6pjER9jYBa2l82bTh4BSRT
	YyMjPGioc8GRAxfvsUig21lC4IYzGaYLePpD/DiOCqRpTNNtsNJQhu/NPrasIbq3
	18ly/szOEi0K8NyWcYfvA==
X-ME-Sender: <xms:TI8gY7uexDV_ENlmZQcnCGUsyCkJbY6dcx0mO-gz4RNXIGLx3MzmUg>
    <xme:TI8gY8ezrVGJ5S1VKLz11ORZfGK8-9KXZ6PEfxVvg9Ld9DQnzzpVALzedn3pr1Dj4
    aQSLgf44IemLeZPVc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedugedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvvefutgesthdtre
    dtreertdenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigr
    nhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhfdvheehgeduue
    etfeevjedtveelvdelhfeuhffffffgheevgeffgeeluefhgfenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhm
X-ME-Proxy: <xmx:TI8gY-ytTht_XBczdpw7bajHrYGByLtDSszl1SfQU-HtRVhb74WKuA>
    <xmx:TI8gY6OBNZPoJEynCJdw0qudUSBj87rN-0JsjhdVevNyp7Oqk3PFzA>
    <xmx:TI8gY79oyNgOBm7iCw0xuS9H-74EpwXFhXv2AhC9hXwP_lqeYisUwQ>
    <xmx:TI8gY9IuSuwxKShopRJsfZtVC1P27MjxfH0ErT0JqPQN-TNJFq74AA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 48DAE36A0073; Tue, 13 Sep 2022 10:10:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-929-g09f3e68182-fm-20220908.004-g09f3e681
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Message-Id: <9e1d3ba6-48ac-4a97-8b65-87e395898c2a@www.fastmail.com>
Date: Tue, 13 Sep 2022 15:09:59 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: iommu@lists.linux.dev
Cc: kvm@vger.kernel.org, ath11k@lists.infradead.org, kvalo@kernel.org,
 dwmw2@infradead.org
Subject: ath11k VFIO MSI issue with DMAR
Content-Type: text/plain

Hi all,

I was trying to do PCIe passthrough for a QCA6390 wireless card.
However I constantly get:

[ 230.587950] DMAR: DRHD: handling fault status reg 2
[ 230.587860] DMAR: [INTR-REMAP] Request device [0x00:0x01] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request

Error on host kernel.

Did a little bit investigation, I found that ath11k hardware is not following
MSI address and data programmed by PCI config space. It maintains MSI address
and data in it's own internal registers (programmed in 
ath11k_ce_srng_msi_ring_params_setup and ath11k_dp_srng_msi_setup).

It means when signalling MSI IRQ, it won't write to the doorbell that expected by
host hardware (in this case, Intel IOMMU DHRD's doorbell for IRQ remapping) but
the doorbell that VFIO made up for guest.

I came up with a simple workaround on host kernel that just handle DRHD 0x25 fault
and deliver MSI to guest according to fault address and data.

So I've got a couple of questions about moving forward:
1. Is this hardware behaviour a violation of PCIe spec?
2. Is it expected for IOMMU to handle those ill-formed MSI requests? If not is
it possible to get this workaround upstreamed?
3. For Qualcomm guys, is it possible to fix this behaviour in ath11k driver or firmware?

Thanks

- Jiaxun
