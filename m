From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 0/3] Support for nesting IOMMUs in VFIO
Date: Wed, 24 Sep 2014 12:25:41 -0600
Message-ID: <1411583141.24563.111.camel@ul30vt.home>
References: <1411550485-32483-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1411550485-32483-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2014-09-24 at 10:21 +0100, Will Deacon wrote:
> Hi all,
> 
> This is version four of the patches I originally posted here:
> 
>   RFCv1: http://permalink.gmane.org/gmane.linux.kernel.iommu/5552
>   RFCv2: http://permalink.gmane.org/gmane.linux.kernel.iommu/5700
>      v3: http://permalink.gmane.org/gmane.linux.kernel.iommu/6230
> 
> The main change since v3 is the mass simplification of the type1 IOMMU
> code based on discussions with Alex. We now unconditionally advertise
> support for nesting IOMMUs and postpone failure until group attach time.
> 
> Alex -- any chance you could queue the first two patches please? I'll
> deal with the arm-smmu patch for 3.19.

I'd need an ack from Joerg to pull in the first patch through vfio.
Thanks,

Alex
