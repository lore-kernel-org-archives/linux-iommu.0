From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/fsl: Really fix init section(s) content
Date: Tue, 3 Mar 2015 14:55:41 +0100
Message-ID: <20150303135541.GM29106@8bytes.org>
References: <1423777528-8143-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423777528-8143-1-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Cc: Varun.Sethi-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 12, 2015 at 03:45:28PM -0600, Emil Medve wrote:
> '0f1fb99 iommu/fsl: Fix section mismatch' was intended to address the modpost
> warning and the potential crash. Crash which is actually easy to trigger with a
> 'unbind' followed by a 'bind' sequence. The fix is/ wrong as
> fsl_of_pamu_driver.driver gets added by bus_add_driver() to a couple of
> klist(s) which become invalid/corrupted as soon as the init sections are freed.
> Depending on when/how the init sections storage is reused various/random errors
> and crashes will happen
> 
> 'cd70d46 iommu/fsl: Various cleanups' contains annotations that go further down
> the wrong path laid by '0f1fb99 iommu/fsl: Fix section mismatch'
> 
> Now remove all the incorrect annotations from the above mentioned patches (not
> exactly a revert) and those previously existing in the code, This fixes the
> modpost warning(s), the unbind/bind sequence crashes and the random
> errors/crashes
> 
> Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>

Please resend this with the Acks, a proper stable-tag and a Fixes: line
with the commit this patch fixes.


	Joerg
