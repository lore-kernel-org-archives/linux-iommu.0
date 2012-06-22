From: "Alexandra N. Kossovsky" <Alexandra.Kossovsky-mK/T7fl7eHLILq5++fvS8w@public.gmane.org>
Subject: atomic context for iommu_map call
Date: Fri, 22 Jun 2012 15:28:14 +0400
Message-ID: <20120622112812.GV8140@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Robert Stonehouse <rstonehouse-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello.

It is not clear from the documentation if iommu_map()/iommu_unmap()
functions may be called from atomic context.
In case of Intel IOMMU, it works; in case of AMD IOMMU, it does not.

Was it done by purpose?  May I propose a patch for AMD IOMMU replacing
GFP_KERNEL by GFP_ATOMIC to make things better?

We use IOMMU API in OpenOnload project http://www.openonload.org/,
and we get better latency with Intel IOMMU because we are not
forced to use threaded IRQ.

-- 
Alexandra N. Kossovsky
OKTET Labs (http://www.oktetlabs.ru/)
