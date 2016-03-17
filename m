From: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v2 0/2] iommu/vt-d: Fault logging improvements
Date: Thu, 17 Mar 2016 14:12:19 -0600
Message-ID: <20160317200557.29049.32879.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, dwmw2@infradead.org
Cc: joe@perches.com, joro@8bytes.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Ratelimit and improve formatting.

v2:

 - Use a single ratelimit state as suggested by Joe Perches, except
   I chose to move it up to dmar_fault() so that it includes the
   "handling fault status reg" pr_err and we can avoid collecting
   entries for logging if we don't plan to print them.
 - Added reformatting changes suggested by Joe Perches.
 - While there is clearly more that could be done with disabling
   fault handling for specific context entries on storm and sending
   errors to drivers, this makes a marked improvement on its own.

Thanks,
Alex

---

Alex Williamson (2):
      iommu/vt-d: Ratelimit fault handler
      iommu/vt-d: Improve fault handler error messages


 drivers/iommu/dmar.c |   47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)
