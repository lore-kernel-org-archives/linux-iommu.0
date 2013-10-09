From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 0/7] iommu/arm-smmu: Misc modifications to support SMMUs on
	Calxeda ECX-2000
Date: Thu, 10 Oct 2013 00:37:59 +0200
Message-ID: <1381358286-27065-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

Here is v2 of arm-smmu changes to support SMMUs on Calxeda ECX-2000.

Note that patch 7/7 (Introduce automatic stream-id-masking) is not
required to support SMMUs on Calxeda ECX-2000. In fact the algorithm
implemented won't help to determine a suitable smr-mask for 10
StreamIDs that we have for SATA.

In case of 2, 4, 8, ... (power-of-two) ... number of StreamIDs for a
master device it might be able (depending on further restriction for
the StreamIDs) to determine the right mask which then allows to use
only one SMR group for stream matching for this master instead of
using several SMR groups (one for each StreamID).

Changelog:
v2:
- Modified options handling
- Added patch to document new DT properties (that select driver options)
- Added patch to introduce automatic stream-id-masking
v1:
   http://marc.info/?l=linux-arm-kernel&m=138122450023564


Regards,
Andreas
