From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: IVDB DTE_ALL Settings
Date: Tue, 4 Aug 2015 18:56:19 +0200
Message-ID: <20150804165619.GP14980@8bytes.org>
References: <20150804025745.GA4128@debian.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150804025745.GA4128-FBVcP3zgNXf1IFe7KZLm3A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Kiarie <davidkiarie4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: valentine.sinitsyn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jankiskza-S0/GAf8tV78@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi David,

On Tue, Aug 04, 2015 at 05:57:45AM +0300, David Kiarie wrote:
> Basically, the iommu->last/first_device fields are initialized in
> another state of the driver much later in the code(during PCI
> initialization); the values iommu->first/last_device are used before
> initialization which breaks the logic of this code.

You are right, this is probably broken for some time, on the other side
it doesn't matter for now as I've never seen an IVRS table with an
IVHD_ALL field. I'll do a patch to fix this, thanks for the report.



	Joerg
