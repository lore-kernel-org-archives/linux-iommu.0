From: Joerg Roedel <Joerg.Roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] iommu/core: pass user-provided token when handling faults
Date: Mon, 21 May 2012 15:25:17 +0200
Message-ID: <20120521132517.GE2604@amd.com>
References: <1337505311-25697-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1337505311-25697-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Fernando Guzman Lugo <fernando.lugo-l0cyMroinI0@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, May 20, 2012 at 12:15:11PM +0300, Ohad Ben-Cohen wrote:
> Sometimes a single IOMMU user may have to deal with several
> different IOMMU devices (e.g. remoteproc).
> 
> When an IOMMU fault happens, such users have to regain their
> context in order to deal with the fault.
> 
> Users can't use the private fields of either the iommu_domain or
> the IOMMU device, because those are already used by the IOMMU core
> and low level driver (respectively).
> 
> This patch just simply allow users to pass a private token (most
> notably their own context pointer) to iommu_set_fault_handler(),
> and then makes sure it is provided back to the users whenever
> IOMMU faults happen.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>

May break compilation for !CONFIG_IOMMU_API. Where is remoteproc
changed? As far as I can see this is the only user of
iommu_set_fault_handler().


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
