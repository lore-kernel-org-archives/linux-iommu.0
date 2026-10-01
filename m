Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA63C3F5D
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896910; cv=none; b=VQR4VEIZot9LfCCTKe+aW/1f8mQJ7Yfy89Seu2TNcDh/lVuqPef2y4MsNJHDFcVoqDIuAxUfld+LYoav+s/Y4XRgRAL3V6UqDBBwlXk/B4vtiGGG++avMhDp5x2USY6UqSbzq6WTOjz0jbYw57H5fXVSCSt9Fh7T44HNUMfMgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896910; c=relaxed/simple;
	bh=CAQJ4AH9ck0dNustqMu2MOb79P0N7gK3NmW0EHyVxR8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rzdLR5LdPyMi0J2FPbMrcO31a4thcvLYKQmM49Rqp1wgda27BfaGWbfylZw19vZlmUUdL1E8yXDnAssIxrVlN2Plp9AsoPpGONKl/3G8iSOeTiyYzuqAPPJ2IQn/rVjAXPUIcQk1T0j3argGoGwFa8ttRY9hXzQqLWnMeOL5NLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ku2bf+Hg; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ku2bf+Hg"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d001671a54so70721965ad.2
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 16:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790896907; x=1791501707; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bH2Pq1q5pIyFrXqiHygcqwFBcPzQ4OFyA1DBLvgDPs4=;
        b=Ku2bf+Hg+WhsNW9hCiA64+DRnjo1kHpAr/tSMJDgIxsUFfsrXoEAcXS/N/tLchcfgG
         5jpV7QbmSpt9aQeJPqA0xWDZy8DSIkXIAH0AykHmaN2X69dyQzf+rhf8iuMMQMneJD3r
         ig+t6VM40QJSuhNm7hpIzno/wapJMTyM3gbMojAp32UrqhwA5V4cbQ1w5Ztr04H/nLZC
         WJq5Trd7h8KHr+8tlNkEix78/hGKftjybEMPwIYsIsljeq6JpsXG0/69oe5n1S3hMmQf
         vKkNYfRDseM6EPMJFaKCCz8dsL1oCXu/0C7tipYu+EkfA2CYCmwhknCue5VRQlYJvAky
         c2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790896907; x=1791501707;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bH2Pq1q5pIyFrXqiHygcqwFBcPzQ4OFyA1DBLvgDPs4=;
        b=MQqhUucDtKZGDxPk+cWeRHlpQygpo0ZFJPjqQTx6amcDgzXU1pZTCT7Ys22SvHvEuN
         DPiEWXpd8VzGocTWVgNYVKr+Ak34LmkKQ7urkv6xdI8cryUw0YXInRS8SwUfoEc438A7
         XzfAWBOOhjMKkVKRZl5PPKbkdiyuLZdOpp737reqFMWqD/oazI6QyJ+vqW2gos5q4aaf
         PlGCbaKOcFiPywmHADx3ZiRcfNXOKRsJP4N11tN3BZ29WM+L0y9gSsqXV5KX8xiSSCiU
         4NiD5rC5zR45BhkwLUYUyPkzLwrGSzrgSa9rF/Amz2yNqHpK01RlLo0vw4pvLEXvMm8d
         npFg==
X-Forwarded-Encrypted: i=1; AKwUvBytYBHTYccms8feZIKFieMlpAXCueqYuJCj09m6Vsw5Cay4XcpReih5Q2MvXmbHKebySn51tQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLzxxyfR6SAcubEEJnZRs/Om+FNs0O9R042RK1Qz6gmQf4kgv0j
	QAQi3VsnoQ7PWDF2ZZNNsQqQDWTmFcSoyVkcB/oWEmaTEDmAKPBTTLj/SymXZ2nECean3zK8/yk
	lSTV327tvFu67aA==
X-Received: from pldv20.prod.google.com ([2002:a17:902:ca94:b0:2e2:f25a:7b5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e807:b0:2dd:ad74:6d16 with SMTP id d9443c01a7336-2e49b6add39mr7150245ad.28.1790896906728;
 Thu, 01 Oct 2026 16:21:46 -0700 (PDT)
Date: Thu,  1 Oct 2026 23:21:07 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001232133.560284-1-dmatlack@google.com>
Subject: RFC: PCI core Live Update Roadmap
From: David Matlack <dmatlack@google.com>
To: linux-pci@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alex Williamson <alex@shazbot.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Kevin Tian <kevin.tian@intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Logan Gunthorpe <logang@deltatee.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Pranjal Shrivastava <praan@google.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

Now that the base PCI core support for Live Update has been applied to
liveupdate.git [1], I wanted to share the plan for the rest of the PCI core
work, so that reviewers can see what is coming and how the pieces fit
together.

I was originally going to present this roadmap at LPC next week [2], but
since there are no immediate blockers, we decided to repurpose the talk to
cover tmpfs file preservation instead [3]. If anyone would like to discuss
the roadmap at LPC, please reach out. I would love to talk about it.

As a reminder, the goal of Live Update is to allow the host kernel to be
updated with kexec while VFIO-assigned PCI devices keep running and keep
doing DMA to guest memory and P2P to other preserved devices. This work
aims to get every PCI core change needed for that merged upstream.

This roadmap only covers functional support in the PCI core. Blackout time
(from VM pause to VM resume) is intentionally out of scope. For preserved
devices, the PCI core mostly skips work it would normally do (bus number
and BAR assignment, ACS/ATS/PASID programming), so these changes should not
add meaningfully to blackout time. Please call out anything in this plan
that would make blackout time worse or harder to optimize later.

The work is split into six series (five feature series plus one selftests
series). Each one will be sent and merged on its own. Feedback on the plan,
the ordering, and the open question in #5 is very welcome.

Overview
========

  #   Series                              Status             Target
  --  ----------------------------------  -----------------  ------
  1   PCI core support for Live Update    v9 applied         7.4
  2   Index saved capability state by     v1 posted          7.5
      configuration space offset
  3   Do not break P2P across             In progress        7.6
      Live Update
  4   Adopt ATS and PASID state across    Not yet posted     7.7
      Live Update
  5   SR-IOV support across Live Update   Not started        7.8
  T1  PCI core Live Update selftests      Not started        7.5

Targets are tentative and based on the usual release cadence [4]. The 7.4
merge window is expected to open in late October 2026, 7.5 in January 2027,
7.6 in March, 7.7 in May, and 7.8 in July. A series needs to be in
linux-next by about rc6 of the preceding cycle to make its target.

Dependencies
============

  LUO FLB refcounting (applied) ---+
                                   |
  LUO FLB fixes (applied) ---------+
                                   |
                                   v
                  #1 PCI core support for Live Update
                                   |
         +-------------+-----------+-----------+-------------+
         |             |                       |             |
         v             v                       v             v
      #3 P2P     #4 ATS/PASID              #5 SR-IOV   T1 Selftests
                 (+ IOMMU Live             (+ VFIO PF
                  Update series)            preservation)

#2 (saved state indexed by config space offset) is an independent PCI
refactor with no dependency on #1. It is a prerequisite for VFIO carrying
struct pci_saved_state across Live Update.

Details
=======

1. PCI core support for Live Update
-----------------------------------

Status: v9 [5] was applied to liveupdate.git on Sep 28 [1] and is in
linux-next, targeting 7.4. Thanks to everyone who reviewed it.

One item from v9 review is still open. Alex pointed out that the ACS Egress
Control Vector is not saved and restored along with the ACS Control
register [6]. An updated patch that handles it is in that thread, and it
will be sent as a follow-up if it turns out to be needed.

This is the base series. It allows preserved PCI devices to keep doing DMA
to system memory (preserved memfds) across Live Update. Devices can sit
behind bridges but cannot be VFs, and P2P is not supported yet. The series:

  - Sets up the PCI core FLB handler that carries struct pci_ser across
    kexec through KHO. The ABI lives in include/linux/kho/abi/pci.h.

  - Adds APIs for drivers to register devices for preservation (outgoing)
    and lets the PCI core recognize preserved devices during enumeration
    (incoming).

  - Automatically preserves every upstream bridge of a preserved endpoint,
    with refcounting.

  - Keeps each preserved device's Requester ID (BDF) the same by inheriting
    secondary/subordinate bus numbers and ARI Forwarding Enable on
    preserved bridges.

  - Keeps TLP routing the same by adopting the ACS controls on the path
    from the endpoint up to the root port. ACS Control is now saved and
    restored through the normal save/restore path.

  - Freezes preservation status at shutdown and leaves Bus Master Enable on
    for preserved devices during kexec.

  - Adds Documentation/PCI/liveupdate.rst describing what the PCI core,
    drivers, and userspace are each responsible for.

Size: 17 files, about 1.4k lines added (mostly the new
drivers/pci/liveupdate.c).

History: v1 was posted in November 2025 together with the VFIO changes [7].
The PCI core changes were split out into their own series in v4 (April
2026) [8].

2. Index saved capability state by configuration space offset
-------------------------------------------------------------

Status: v1 [9] (15 patches) was posted on Sep 24 and is waiting for review.
It is intended to go through pci.git and has no dependency on #1.

Why: VFIO saves a device's state with pci_store_saved_state() on first open
and restores it with pci_load_and_free_saved_state() on last close. A Live
Update can happen between those two calls. Today struct pci_saved_state
cannot be handed to the next kernel, because its layout depends on the
kernel that wrote it (which capabilities are recorded, how big each record
is, what each word means). The receiving kernel has no way to check it
against the device in front of it.

What: Replace the per-capability save buffers with a single per-device
store indexed by config space offset (new drivers/pci/saved-caps.c), and
lay out struct pci_saved_state the same way: a bitmap of saved DWORDs plus
their values. The format of the blob then comes from the hardware rather
than the kernel version, so any kernel can check it.

Side benefits:

  - One saved-state allocation per device instead of up to nine separate
    ones. The one remaining allocation failure is reported (AER, DPC, PTM,
    and TPH used to ignore allocation failures).

  - Removes fragile save/restore ordering that relied on running buffer
    cursors. Restore routines now name registers by offset.

  - Saves 32 to 160 bytes per device, and fixes a possible unaligned access
    in pci_load_saved_state().

Size: 13 files, +680/-621. The series is bisect-safe and converts one
capability per patch, so feedback on one capability does not have to hold
up review of the rest.

Follow-on work (not part of this series): Serializing struct
pci_saved_state across Live Update (a KHO ABI definition in
include/linux/kho/abi/ plus serialize/deserialize routines) will be part of
the VFIO Live Update work rather than a separate PCI core series. It builds
on the offset-indexed layout from this series. Separately, the remaining
saved-state allocation failure should be made fatal to device setup.

3. Do not break P2P across Live Update
--------------------------------------

Status: In progress, not yet posted.

Scope: This series only ensures that the PCI core does not break ongoing
P2P between preserved devices across Live Update, e.g. by changing BAR
addresses. Actually supporting P2P across Live Update will also require
work in VFIO and a story around preserving dma-bufs.

Why: Preserved devices may be doing peer-to-peer DMA to each other
throughout the Live Update, e.g. device-to-device traffic between
VFIO-assigned devices in a VM. That traffic breaks if the next kernel
changes BAR addresses or bridge windows during enumeration. Independent of
P2P, VFIO also needs stable BAR addresses so that it can safely preserve
the rbar field in struct vfio_pci_core_device.

Approach: This touches PCI resource code (preserve_config, BAR sizing). The
new behavior will be limited to incoming preserved devices, so that boots
without Live Update are unaffected, and existing mechanisms such as
preserve_config will be reused rather than adding new ones.

Dependencies: #1 and the LUO FLB fixes (applied).

Next steps: Rebase onto the applied base series and post an RFC, so that
review of the resource assignment changes can overlap with #1 soaking in
linux-next. Early feedback on the approach from Bjorn and the PCI resource
reviewers would be much appreciated.

4. Adopt ATS and PASID state across Live Update
-----------------------------------------------

Status: Patches written, not yet posted.

Why: Turning ATS or PASID on or off while a device is doing DMA is unsafe.
Enabling ATS is not atomic (the IOMMU context entry and the endpoint's ATS
Control register are separate), and disabling ATS without quiescing DMA can
leave stale ATC translations behind, which risks silent memory corruption.
For preserved devices the kernel must adopt the existing hardware state
instead of reprogramming it.

Dependencies: #1. Samiullah's IOMMU Live Update series [10] also needs to
land for this to be useful end to end, since the IOMMU driver is what calls
into ATS/PASID enablement. The plan is to post #4 once the IOMMU series has
settled (targeting 7.7, with 7.6 as a stretch), and to agree on the
ATS/PASID adoption interface with Samiullah ahead of time. Alternatively,
these PCI core patches may be folded into a larger IOMMU series from
Samiullah that handles ATS and PASID end to end.

5. SR-IOV support across Live Update
------------------------------------

Status: Not started.

Why: VFs assigned to VMs through VFIO need to survive Live Update. That
means preserving the parent PF's SR-IOV configuration (NumVFs, VF Enable,
VF BARs, etc.) and enumerating the VFs after kexec without resetting or
reconfiguring them.

Scope: Userspace must explicitly preserve a PF for a VF to be preserved.
Unlike upstream bridges, the PCI core will not automatically preserve the
PF of a preserved VF. The PF must be explicitly preserved by its driver.

Expected work:

  - Remove the base series' restriction against preserving VFs.

  - Preserve and adopt the PF's SR-IOV capability state instead of
    reprogramming it on the incoming side.

  - Enumerate VFs on the incoming side while keeping their Requester IDs
    and BARs unchanged (builds on the bus number and BAR work in #1 and
    #3).

Open question: When should the VFs be enumerated on the incoming side? The
PCI core has enough information to enumerate them during the initial bus
scan, but userspace may prefer to trigger enumeration itself after
disabling VF autoprobe (sriov_drivers_autoprobe).

Dependencies: #1 and VFIO PF preservation support.

T1. PCI core Live Update selftests
----------------------------------

Status: Not started.

Why: PCI core support for Live Update is currently tested by applying the
VFIO series [11] on top and running the VFIO Live Update selftests. That
works for basic sanity testing, but it will make it harder to test new PCI
core features that need to land ahead of their VFIO counterparts. Adding
PCI core specific tests under tools/testing/selftests/liveupdate would make
PCI core development less coupled to VFIO. That requires a test driver,
provided by the selftests, that can preserve devices without VFIO.

Dependencies: #1.

Related work outside the PCI core
=================================

  - LUO: Refcounting for incoming FLB [12]. Applied in May. Needed by #1,
    #3, and #5.

  - LUO: FLB fixes, outgoing refcounting, and preventing multiple retrieve
    [13]. Applied in July. Needed by #1, #3, and #5.

  - Vipin's VFIO PCI Live Update series (v5) [11]. Under review. The main
    user of #1, and a future user of #2 (saved state) and #5 (PF/VF).

  - Samiullah's IOMMU Live Update series (v5) [10]. Posted on Sep 21.
    Needed end to end for DMA through the IOMMU. Pairs with #4.

  - LUO file dependencies (Samiullah). LPC talk planned. Needed for
    VFIO/iommufd ordering and for PF/VF dependencies (#5).

Thanks,
David

[1] https://lore.kernel.org/linux-pci/179061032462.173069.6066907606098407222.b4-ty@b4/
[2] https://lpc.events/event/20/contributions/2618/
[3] https://lore.kernel.org/kexec/20260925143000.2729890-1-pasha.tatashin@soleen.com/
[4] https://deb.tandrin.de/phb-crystal-ball.htm
[5] https://lore.kernel.org/linux-pci/20260918200640.887030-1-dmatlack@google.com/
[6] https://lore.kernel.org/linux-pci/20260918191846.2f68b23b@shazbot.org/
[7] https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/
[8] https://lore.kernel.org/linux-pci/20260423212316.3431746-1-dmatlack@google.com/
[9] https://lore.kernel.org/linux-pci/20260924173501.856380-1-dmatlack@google.com/
[10] https://lore.kernel.org/linux-iommu/20260921004834.2601285-1-skhawaja@google.com/
[11] https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/
[12] https://lore.kernel.org/lkml/177766042304.401635.6805828117822344063.b4-ty@soleen.com/
[13] https://lore.kernel.org/kexec/178448096578.306041.16503153363800577876.b4-ty@b4/
