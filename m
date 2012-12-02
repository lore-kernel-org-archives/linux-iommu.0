From: "Kinney, Steven" <Steven.Kinney-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/1] iommuv2/amd: Enable Performance Counters On Family
	15h Models 10h-1Fh
Date: Sun, 2 Dec 2012 21:55:09 +0000
Message-ID: <57D41218901B4442B4AFF404D215911636ABC6@sausexdag02.amd.com>
References: <1353967225-18742-1-git-send-email-steven.kinney@amd.com>
	<20121202133026.GN30633@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20121202133026.GN30633-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Hurwitz, Sherry" <sherry.hurwitz-5C7GfCeVMHo@public.gmane.org>, Joerg Roedel <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

                  I didn't want to expose the internals of the IOMMU, so I decided to export the function(s) so that the perf IOMMUv2 PMU can make call(s) into the IOMMU core to request PC resources.  The perf_event_amd_iommuv2.h defines the prototype for the added PC functionality.  I have the perf IOMMUv2 PMU working and counting IOMMUv2 PC events using this interface, but if  you have a suggestion to make this implementation more robust, I will accommodate the suggestion.  Also, if it would be helpful, I can submit the perf IOMMUv2 PMU patches.  

BTW, I am resubmitting this patch since I caught a function signature error; was changing the code based on Boris's suggestion(s) and forgot to add the variable type (bool) concerning the 'is_write' parameter.

Hope all is well with you and the team; we miss you guys!

Regards,

Steve

-----Original Message-----
From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org] 
Sent: Sunday, December 02, 2012 7:30 AM
To: Kinney, Steven
Cc: Joerg Roedel; Kukjin Kim; Stephen Warren; Jiri Kosina; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Subject: Re: [PATCH 1/1] iommuv2/amd: Enable Performance Counters On Family 15h Models 10h-1Fh

On Mon, Nov 26, 2012 at 04:00:25PM -0600, Steven Kinney wrote:
> From: "Steven L. Kinney" <steven.kinney-5C7GfCeVMHo@public.gmane.org>
> 
> Add Kernel configuration selection for AMD IOMMUv2 performance 
> counters.

How can the counters be used?


	Joerg
