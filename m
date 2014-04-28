From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v5 02/11] ARM SMMU: Add capability IOMMU_CAP_DMA_EXEC
Date: Mon, 28 Apr 2014 14:20:40 -0600
Message-ID: <1398716440.24318.330.camel@ul30vt.home>
References: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>
	<1398700371-20096-3-git-send-email-a.motakis@virtualopensystems.com>
	<20140428193709.GE22135@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140428193709.GE22135-5wv7dgnIgG8@public.gmane.org>
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
Cc: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "moderated list:ARM SMMU DRIVER" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2014-04-28 at 20:37 +0100, Will Deacon wrote:
> On Mon, Apr 28, 2014 at 04:52:42PM +0100, Antonios Motakis wrote:
> > The ARM SMMU can take an IOMMU_EXEC protection flag in addition to
> > IOMMU_READ and IOMMU_WRITE. Expose this as an IOMMU capability.
> 
> The other way of handling this would be to negate the capability and
> advertise a NOEXEC cap instead. That would need the IOMMU_EXEC flag to
> become IOMMU_NOEXEC and the ARM SMMU driver updating accordingly, but it
> might make more sense if people don't object to mixing positive and negative
> logic in the IOMMU_* flags.
> 
> Any thoughts?

A benefit of doing that would be that the flag becomes enforceable.  As
written in this draft, if a user does not specify EXEC, the mapping may
or may not be executable, depending on the IOMMU capability (assuming
that if EXEC is not supported that it follows READ).  If the flag
changes to NOEXEC, then all the domains in the container should support
it or else the mapping should fail.  We could also avoid the test in
vfio code when doing a mapping and just let the IOMMU driver fail the
map if NOEXEC is unsupported.  Thanks,

Alex
