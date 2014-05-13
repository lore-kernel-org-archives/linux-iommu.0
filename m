From: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 1/1] iommu/amd: fix enabling exclusion range for an
	exact device
Date: Tue, 13 May 2014 12:35:56 +0200
Message-ID: <20140513103556.GB23770@8bytes.org>
References: <053191AD6E9023439BF3970DE87005185086D31DA3@APSHAXMS02.ap.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <053191AD6E9023439BF3970DE87005185086D31DA3-vLFws2UBKuUBqgaMIWwxlo3UfPj+9hkl@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Su, Friendy" <Friendy.Su-7U/KSKJipcvM1kAEIRd3EQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, May 07, 2014 at 01:54:52PM +0800, Su, Friendy wrote:
> 
> From: Su Friendy <friendy.su-7U/KSKJipcvM1kAEIRd3EQ@public.gmane.org>
> 
> set_device_exclusion_range(u16 devid, struct ivmd_header *m) enables
> exclusion range for ONE device. IOMMU does not translate the access
> to the exclusion range from the device.
> 
> The device is specified by input argument 'devid'. But 'devid' is not
> passed to the actual set function set_dev_entry_bit(), instead
> 'm->devid' is passed. 'm->devid' does not specify the exact device
> which needs enable the exclusion range. 'm->devid' represents DeviceID
> field of IVMD, which has different meaning depends on IVMD type.
> 
> The caller init_exclusion_range() sets 'devid' for ONE device. When
> m->type is equal to ACPI_IVMD_TYPE_ALL or ACPI_IVMD_TYPE_RANGE,
> 'm->devid' is not equal to 'devid'.
> 
> This patch fixes 'm->devid' to 'devid'.
> 
> Signed-off-by: Su Friendy <friendy.su-7U/KSKJipcvM1kAEIRd3EQ@public.gmane.org>
> Signed-off-by: Tamori Masahiro <Masahiro.Tamori-7rVYBvDxQfZBDgjK7y7TUQ@public.gmane.org>

Applied, thanks.
